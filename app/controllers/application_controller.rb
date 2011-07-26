class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :try_and_login_with_fb_cookie
  before_filter :decode_signed_request
  before_filter :route_to_donate_page
  helper_method :current_user, :logged_in?
  helper_method :in_facebook_page_donate_url, :in_facebook_page_app_url
  
  def try_and_login_with_fb_cookie
    fb_info = MiniFB.parse_cookie_information(FB_APP_ID, cookies) # some users may have to use their API rather than the app. ID.
    return if fb_info.nil?
    logger.debug "Found facebook cookie, uid=#{fb_info['uid']} session=#{fb_info['session_key']}"
    if MiniFB.verify_cookie_signature(FB_APP_ID, FB_APP_SECRET, cookies)
      user = User.find_by_fbid(fb_info['uid'])
      if user
        log_in_user!(user)
      else
        # connected user but no User record - just ignore
        logger.warn "Facebook cookie found but couldn't find User for uid #{fb_info['uid']}"
      end
    else
      # The cookies may have been modified as the signature does not match
      logger.warn "Facebook cookie didn't verify!"
    end
  end
  
  def decode_signed_request
    if params[:signed_request]
      request = RestGraph.new(:secret => FB_APP_SECRET).parse_signed_request!(params[:signed_request])
      if request
        @signed_request_data = request
      else
        logger.error "Failed to decode params[:signed_request]"
      end
    end
  end
  
  # Another before filter that looks at the app_data in the signed_request to
  # see whether the URL is really a donate URL. If it is, then we redirect
  # immediately to the donate controller
  def route_to_donate_page
    if @signed_request_data && @signed_request_data['app_data']
      if @signed_request_data['app_data'] =~ /^donate_([a-zA-Z0-9]+)$/
        url = donate_url(:token => $1)
        logger.info("Routing facebook user to donate url: #{url}")
        redirect_to url
      end
    end
  end
  
  def current_user
    User.find_by_id(session[:user_id])
  end
  
  def logged_in?
    !current_user.nil? && params[:test_anon] != '1'
  end
  
  def log_in_user!(user)
    session[:user_id] = user.id
  end
  
  # Generate URL to the app installed within our facebook page
  def in_facebook_page_app_url
    "http://www.facebook.com/#{FB_PAGE_NAME}?sk=app_#{FB_APP_ID}"
  end
  
  # Generate URL to a user's donate page within the app installed within our facebook page
  # (also see ApplicationController#route_to_donate_page)
  def in_facebook_page_donate_url(user)
    "http://www.facebook.com/#{FB_PAGE_NAME}?sk=app_#{FB_APP_ID}&app_data=donate_#{user.donate_token}"
  end
  
end
