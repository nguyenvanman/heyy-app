class RenameColumnSavedContents < ActiveRecord::Migration[5.2]
  def change
    rename_column :saved_contents, :type, :save_content_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
