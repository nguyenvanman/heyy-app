class User < ApplicationRecord
    has_secure_password

    has_many :questions

    validates :name, presence: true
end
