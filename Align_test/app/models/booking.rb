class Booking < ApplicationRecord
  validates :desk, :date_from, :date_to , presence: true
end
