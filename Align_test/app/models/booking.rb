class Booking < ApplicationRecord
  validates :desk, :date_from, :date_to , presence: true
  belongs_to :user
end
