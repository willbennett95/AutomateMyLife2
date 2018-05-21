class DropFriendshipsTable < ActiveRecord::Migration
  def up
    drop_table :friendship
  end
end
