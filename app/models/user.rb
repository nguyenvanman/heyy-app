class User < ApplicationRecord
    before_save :downcase_email
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    has_secure_password
    has_many :questions

    validates :name, presence: true
    validates :email,   presence: true,
                        length: { maximum: 255},
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    
    private 

    def downcase_email
        self.email = email.downcase
    end
end
