class HomepageController < ApplicationController
  
  def index
    @leaders = User.leaders(10)
  end
  
end
