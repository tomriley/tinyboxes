class AddUserDonateToken < ActiveRecord::Migration
  def self.up
    add_column :users, :donate_token, :string
    User.find_each do |u|
      u.assign_donate_token
      u.save
    end
    add_index :users, :donate_token
  end

  def self.down
    remove_column :users, :donate_token
  end
end