class Campaign < ApplicationRecord
  validates :bio, presence: true
  validates :description, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
