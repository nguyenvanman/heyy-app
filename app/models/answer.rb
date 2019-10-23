class Answer < ApplicationRecord
  belongs_to :user_question

  def answered_at
    created_at
  end
end
