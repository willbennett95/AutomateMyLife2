class AddUsernameToUsers < ActiveRecord::Migration
  # gets translated to SQL
  def change 
    add_column :users, :username, :string
    add_index :users, :username, unique: true   # ensures a username cannot be reused
  end
end
