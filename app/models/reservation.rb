class Reservation < ActiveRecord::Base
  belongs_to :listing
  has_one :host, through: :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true

  validate :host_and_guest_must_be_different
  validate :no_time_conflicts
  validate :checkout_time_after_checkin_time

  def duration
    (checkout - checkin).to_i
  end

  def total_price
    duration * listing.price
  end

  def host_and_guest_must_be_different
    if host == guest
      errors.add(:host, "cannot be guest")
      errors.add(:guest, "cannot be host")
    end
  end

  def no_time_conflicts
    if checkin && checkout && !listing.available(checkin, checkout)
      errors.add(:checkin, "must be available")
      errors.add(:checkout, "must be available")
    end
  end

  def checkout_time_after_checkin_time
    if checkin && checkout && checkout <= checkin
      errors.add(:checkin, "must be before checkout")
      errors.add(:checkout, "must be after checkin")
    end
  end
end
