class Website < ApplicationRecord
  belongs_to :user

  has_secure_token :secrete_token

  validates :name, :domain_name, presence: true
end
