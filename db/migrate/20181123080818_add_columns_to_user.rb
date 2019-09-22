class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :username, :string
    add_column :users, :slug, :string
    add_column :users, :role, :integer, default: 0
    add_index :users, :slug, unique: true
    add_index :users, :username, unique: true
    add_column :users, :avatar, :string
  end
end
