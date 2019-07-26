class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :question
      t.text :answer

      t.timestamps
    end

    add_reference :questions, :user, foreign_key: true
    add_index :questions, [:user_id, :question], unique: true
  end
end
