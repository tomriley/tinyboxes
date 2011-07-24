class LeaderboardController < ApplicationController
  
  def board
    @leaders = User.leaders(10)
  end
  
end