class Answer < ApplicationRecord
    belongs_to :question

    def answered_at
        created_at
    end
end
