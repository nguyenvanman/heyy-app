class UpdateAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :question_id, :user_question_id
  end
end
