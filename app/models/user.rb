class User < ActiveRecord::Base
  has_many :donations, :dependent => :destroy
  attr_accessible :name
end