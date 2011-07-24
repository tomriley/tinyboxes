class HomepageController < ApplicationController
  
  def index
    @oauth_url = MiniFB.oauth_url( '117660584915213', # your Facebook App ID (NOT API_KEY)
                                   "http://localhost:3000/sessions/create", # redirect url
                                   :scope => MiniFB.scopes.join(",") )
  end
  
end
