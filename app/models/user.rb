class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token :token

  has_many :reservations, dependent: :destroy

  enum role: %i[admin operator]

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def authenticate(password)
    if super
      regenerate_token
      token
    end
  end
end
