class User < ApplicationRecord
    before_save :downcase_email

    attr_accessor :reset_token
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    has_secure_password

    has_many :user_questions, dependent: :destroy
    has_many :questions, through: :user_questions, source: :question

    validates :name, presence: true
    validates :email,   presence: true,
                        length: { maximum: 255},
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }

    def questions
        self.user_questions.map { |uq| QuestionSerializer.new(uq.question, uq).call }
    end
    
    def self.digest(string)
        cost = if ActiveModel::SecurePassword.min_cost
                BCrypt::Engine::MIN_COST
            else
                BCrypt::Engine.cost
            end
        BCrypt::Password.create(string, cost: cost)
    end

    def authenticated?(token)
        digest = send(:reset_digest)
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def password_reset_expired?
        reset_sent_at < 1.hours.ago
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attributes(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self, self.reset_token).deliver_later
    end

    private 

    def downcase_email
        self.email = email.downcase
    end
end
