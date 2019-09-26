class UpdateQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :application
    remove_column :questions, :latest_answer
    remove_column :questions, :user_id
  end
end
