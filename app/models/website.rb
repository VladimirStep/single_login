class Website < ApplicationRecord
  belongs_to :user

  validates :name, :domain_name, presence: true
end
