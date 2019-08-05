class AddApplicationToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :application, :string
  end
end
