class Question < ApplicationRecord
    belongs_to :user
    has_many :answers, -> { order 'created_at desc' }

    validates :question, presence: true
    validates :application, presence: true

    def answer
        unless answers.blank?
            answers.order(created_at: :desc).first.answer    
        else
            "" 
        end
    end
end
