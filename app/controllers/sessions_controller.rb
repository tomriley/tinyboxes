class SessionsController < ApplicationController
  
  def login
    @oauth_url = MiniFB.oauth_url(FB_APP_ID, # your Facebook App ID (NOT API_KEY)
                                  oauth_return_url, # redirect url
                                  :scope => FB_PERMS)
  end
  
  def logout
    reset_session
    redirect_to root_path
  end
  
  def oauth_return
    access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, oauth_return_url, FB_APP_SECRET, params[:code])
    @access_token = access_token_hash["access_token"]
    @response_hash = MiniFB.get(@access_token, 'me', :type=>nil)
    uid = @response_hash['id']
    user = User.find_by_fbid(uid)
    if user.nil?
      user = User.new
      user.fbid = uid
      user.name = @response_hash['name']
      user.token = @access_token
      user.save!
    end
    log_in_user!(user)
    # Now redirect back to the app within facebook page
    redirect_to in_facebook_page_app_url
  end
  
end