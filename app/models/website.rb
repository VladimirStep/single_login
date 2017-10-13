class Website < ApplicationRecord
  belongs_to :user
  has_one :granted_access, dependent: :destroy

  has_secure_token :secrete_token

  before_create :create_secure_id

  validates :name, :domain_name, presence: true

  def create_secure_id
    self.secrete_id = SecureRandom.uuid
  end
end
