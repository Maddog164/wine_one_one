class User < ApplicationRecord
    has_secure_password #validation prresence of password
    has_many :wines
    validates :user_name, presence: true
    validates :user_name, uniqueness: true

    def self.create_from_omniauth(auth)
        binding.pry
        User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.user_name = auth['info']['first_name']
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(16)
        end
        binding.pry
    end

end
