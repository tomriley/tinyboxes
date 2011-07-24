class HomepageController < ApplicationController
  
  def index
    redirect_to login_path if !logged_in? 
  end
  
end
