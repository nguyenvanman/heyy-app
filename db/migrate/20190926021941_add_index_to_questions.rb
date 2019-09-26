class AddIndexToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :content, unique: true
  end
end
