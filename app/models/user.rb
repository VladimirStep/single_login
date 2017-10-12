class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :websites, dependent: :destroy

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }

  def self.try_authenticate(email, password)
    self.find_by_email(email).try(:authenticate, password)
  end
end
