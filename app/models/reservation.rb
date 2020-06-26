class Reservation < ActiveRecord::Base
  # include ActiveModel::Validations
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  validates :checkin, presence: true
  validates :checkout, presence: true
  validates_with ReservationValidator

  def duration
    self.checkout - self.checkin
  end

  def total_price
    self.duration * self.listing.price
  end
end
