class SessionsController < ApplicationController
  
  def login
    @oauth_url = MiniFB.oauth_url(FB_APP_ID, # your Facebook App ID (NOT API_KEY)
                                  oauth_return_url, # redirect url
                                  :scope => MiniFB.scopes.join(",")) # This asks for all permissions
  end
  
  def logout
    session.delete(:user_id)
    redirect_to root_path
  end
  
  def oauth_return
    access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, oauth_return_url, FB_APP_SECRET, params[:code])
    @access_token = access_token_hash["access_token"]
    @response_hash = MiniFB.get(@access_token, 'me', :type=>nil)
    uid = @response_hash['id']
    user = User.find_by_fbid(uid)
    if user
      session[:user_id] = user.id
    else
      user = User.new
      user.fbid = uid
      user.name = @response_hash['name']
      user.token = @access_token
      user.save!
    end
    session[:user_id] = user.id
    redirect_to "http://www.facebook.com/#{FB_PAGE_NAME}?sk=app_#{FB_APP_URL}"
    #redirect_to ENV['FB_APP_URL'] # go back to facebook
  end
  
end