class Website < ApplicationRecord
  belongs_to :user
  has_many :granted_accesses, dependent: :destroy

  has_secure_token :secrete_token

  before_create :create_secure_id

  validates :name, :domain_name, presence: true

  def create_secure_id
    self.secrete_id = SecureRandom.uuid
  end

  def self.try_authenticate(id, token)
    site = self.find_by_secrete_id(id)
    real_token = site.try(:secrete_token)
    real_token == token ? site : nil
  end
end
