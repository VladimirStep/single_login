class GrantedAccess < ApplicationRecord
  belongs_to :user
  belongs_to :website

  before_create :generate_tokens

  def generate_tokens
    self.code = SecureRandom.hex(16)
    self.access_token = SecureRandom.hex(16)
    self.refresh_token = SecureRandom.hex(16)
    self.access_token_expires_at = Time.now + 6.hours
  end

  def self.try_authenticate(token)
    access = self.find_by_access_token(token)
    access&.user
  end

  def refresh_access_token
    self.access_token = SecureRandom.hex(16)
    self.access_token_expires_at = Time.now + 6.hours
    self.save
  end
end
