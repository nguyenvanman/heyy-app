class CreateSavedContents < ActiveRecord::Migration[5.2]
  def change
    create_table :saved_contents do |t|

      t.json :content
      t.column :type, :saved_content_type
      t.bigint :user_id
      t.timestamps
    end
  end
end
