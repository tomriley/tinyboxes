class User < ActiveRecord::Base
  include TokenGenerator
  has_many :donations, :dependent => :destroy
  attr_accessible :name
  before_validation :assign_token, :on => :create
  
  def self.leaders(n = 10)
    self.order('money DESC').limit(n)
  end
  
  def assign_token
    self.token = generate_token(10, :alpha_num) { |id| User.find_by_token(id).nil? }
  end
  
end