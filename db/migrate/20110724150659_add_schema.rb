class AddSchema < ActiveRecord::Migration
  def self.up
      create_table "users", :force => true do |t|
          t.string  "token"
          t.string   "fbid"
          t.string   "name"
          t.decimal "money", :precision => 8, :scale => 2, :default => 0
          t.integer "points", :default => 0
          t.timestamps
      end
      add_index "users", ["points"], :name => "points"
      add_index "users", ["money"], :name => "money"
      add_index "users", ["fbid"], :name => "fbid"      
      
      create_table "donations", :force => true do |t|
          t.integer "user_id"
          t.string   "description"
          t.decimal "amount", :precision => 8, :scale => 2, :default => 0
          t.timestamps
      end
      add_index "donations", ["user_id"], :name => "user_id"
      add_index "donations", ["amount"], :name => "amount"      
      
  end

  def self.down
      drop_table "users"
      drop_table "donations"
  end
end
