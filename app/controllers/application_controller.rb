class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :try_and_login_with_fb_cookie

  helper_method :current_user, :logged_in?
  
  def current_user
    User.find_by_id(session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def try_and_login_with_fb_cookie
    fb_info = MiniFB.parse_cookie_information(FB_APP_ID, cookies) # some users may have to use their API rather than the app. ID.
    return if fb_info.nil?
    
    logger.info "uid=#{fb_info['uid']}"
    logger.info "session=#{fb_info['session_key']}"
    
    if MiniFB.verify_cookie_signature(FB_APP_ID, FB_SECRET, cookies)
      user = User.find_by_fbid(fb_info['uid'])
      if user
        session[:user_id] = user.id
      else
        # connected user but no User record - just ignore
      end
    else
      # The cookies may have been modified as the signature does not match
    end

  end
  
end
