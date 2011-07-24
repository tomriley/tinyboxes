class User < ActiveRecord::Base
  has_many :donations, :dependent => :destroy
  attr_accessible :name
  
  def self.leaders(n = 10)
    self.order('money DESC').limit(n)
  end
  
end