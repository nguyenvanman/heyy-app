class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :answers, -> { order "created_at desc" }, dependent: :destroy
end
