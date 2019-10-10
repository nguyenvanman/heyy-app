class UpdateSavedContents < ActiveRecord::Migration[5.2]
  def change
    add_column :saved_contents, :mhid, :string, unique: true
    add_column :saved_contents, :image, :string
    add_column :saved_contents, :name, :string, unique: true

    add_index :saved_contents, :mhid, unique: true
    remove_column :saved_contents, :content
    #Ex:- add_index("admin_users", "username")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
