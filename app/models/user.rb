class User < ActiveRecord::Base
    has_many :donations
end