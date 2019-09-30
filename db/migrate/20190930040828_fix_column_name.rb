class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :saved_contents, :save_content_type, :content_type
  end
end
