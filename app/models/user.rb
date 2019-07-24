class User < ApplicationRecord
    validates :uid, presence: true

    has_secure_password
end
