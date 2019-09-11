class Question < ApplicationRecord
    belongs_to :user
    has_many :answers, -> { order 'created_at desc' }

    validates :content, presence: true
    validates :application, presence: true

    def answer
        latest_answer
    end
end
