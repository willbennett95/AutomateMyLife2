class AddProfilepicturesToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profilepic
    end
  end
  
  def self.down
    drop_attached_file :users, :profilepic
  end
end
