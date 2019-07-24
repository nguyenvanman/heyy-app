class UpdateUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string, null: true
    add_column :users, :is_admin, :boolean, defauld: false
  end
end
