class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :answers, dependent: :destroy
end
