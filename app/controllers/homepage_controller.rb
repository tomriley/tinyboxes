class HomepageController < ApplicationController
  
  def index
    @leaders = User.leaders(10)
    #redirect_to login_path if !logged_in? 
  end
  
end
