class SessionsController < ApplicationController
    before_filter :load_fb
    def login
        @fb_user = @fb_graph.get_object(session[:fb_id])
        @friends = @fb_graph.get_connections("me", "friends", {:fields => "id, first_name, last_name"})
        render :text => @friends.to_json
    end

    def logout
        reset_session
        redirect_to :controller => :homepage, :action => :index
    end


    private
    def load_fb
        @fb_oauth = Koala::Facebook::OAuth.new

        if session[:token]
            @fb_token = session[:token]
            @fb_graph =Koala::Facebook::GraphAndRestAPI.new(@fb_token)  

        elsif @fb_oauth.get_user_info_from_cookies(cookies) && @fb_oauth.get_user_info_from_cookies(cookies)["access_token"]
            session[:token] = @fb_token = @fb_oauth.get_user_info_from_cookies(cookies)["access_token"]
            @fb_graph =Koala::Facebook::GraphAndRestAPI.new(@fb_token)  
            session[:fb_id] = @fb_id = @fb_oauth.get_user_info_from_cookies(cookies)["uid"]
            
            veteran = User.find_by_fbid(@fb_id)
            if !veteran  
                @first_time = true
                name = @fb_graph.get_object(session[:fb_id])['name']
                User.create(:fbid => @fb_id, :token => @fb_token, :name => name)           
            end
        else
            redirect_to :root 
        end
    end
end