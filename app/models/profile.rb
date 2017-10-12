class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  validates :first_name, :last_name, :gender, :birth_date, :street, :city, :country, presence: true
end
