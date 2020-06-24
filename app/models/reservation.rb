class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  
  validates :checkin, :checkout, presence: true
  validate :diff_users, :good_reservation, :good_timing



  def duration()
    (checkout-checkin).to_i
  end

  def total_price()
    duration() * self.listing.price
  end

  private

  def diff_users
    return if !self.guest
    if self.guest.id == self.listing.host_id
      errors.add(:reservation, "Same host and guest")
    end
  end

  def good_timing()
    if checkout && checkin && self.checkout <= self.checkin
      errors.add(:reservation, "Can't check out before check in")
    end
  end

  def good_reservation()
    if checkin && checkout && (!not_between_any(checkin) || !not_between_any(checkout))
      errors.add(:reservation, "Already booked")
    end
  end

  def not_between_any(time_inst)
    self.listing.reservations.reduce(true){|good, l| 
      good && !time_inst.between?(l.checkin, l.checkout)
    }
  end
end
