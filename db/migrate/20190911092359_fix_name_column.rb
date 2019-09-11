class FixNameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :question, :content
    rename_column :answers, :answer, :content
  end
end
