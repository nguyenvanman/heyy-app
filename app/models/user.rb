class User < ApplicationRecord
    before_save :downcase_email

    attr_accessor :reset_token
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    has_secure_password
    has_many :questions

    validates :name, presence: true
    validates :email,   presence: true,
                        length: { maximum: 255},
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    
     # Returns the hash digest of the given string.
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
        UserMailer.password_reset(self).deliver_now
    end

    private 

    def downcase_email
        self.email = email.downcase
    end
end
