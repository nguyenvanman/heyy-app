class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :lastest_answer, :latest_answer
  end
end
