class RenameColumnLatestAnswer < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_questions, :lastest_answer, :latest_answer
  end
end
