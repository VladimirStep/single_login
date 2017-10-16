class GrantedAccess < ApplicationRecord
  belongs_to :user
  belongs_to :website

  before_create :generate_tokens

  def generate_tokens
    self.code = SecureRandom.hex(16)
    self.access_token = SecureRandom.hex(16)
  end

  def self.try_authenticate(token)
    access = self.find_by_access_token(token)
    access&.user
  end
end
