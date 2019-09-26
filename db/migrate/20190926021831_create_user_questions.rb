class CreateUserQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_questions do |t|
      t.bigint :user_id
      t.bigint :question_id
      t.text :lastest_answer
      t.text :application
      t.json :traversal_path

      t.timestamps
    end
  end
end
