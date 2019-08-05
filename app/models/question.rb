class Question < ApplicationRecord
    belongs_to :user

    validates :question, presence: true
    validates :answer, presence: true
    validates :application, presence: true
end
