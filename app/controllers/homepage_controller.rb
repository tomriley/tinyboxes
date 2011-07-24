class HomepageController < ApplicationController
  
  def index
      @fb_oauth = Koala::Facebook::OAuth.new
      @fb_graph =Koala::Facebook::GraphAndRestAPI.new  # can only access public datam, temporary.
  end
  
end
