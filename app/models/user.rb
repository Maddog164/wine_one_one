class User < ApplicationRecord
    has_secure_password
    has_many :wines
    validates :user_name, presence: true
    validates :user_name, uniqueness: true

end
