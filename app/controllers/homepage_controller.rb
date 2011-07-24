class HomepageController < ApplicationController
  
  def index
      @fb_oauth = Koala::Facebook::OAuth.new
      @fb_graph =Koala::Facebook::GraphAndRestAPI.new  # can only access public datam, temporary.
  end
  
  def login
      @fb_user = @fb_graph.get_object(session[:fb_id])
      @friends = @fb_graph.get_connections("me", "friends", {:fields => "id, first_name, last_name"})
      render :text => @friends.to_json
  end

  def logout
      reset_session
      redirect_to :controller => :homepage, :action => :index
  end
  
  
  
end
