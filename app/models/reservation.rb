class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true 
  validate :not_your_listing 
  validate :listing_available
  validate :date_valid

  def date_valid
    # also must check for nil values
    if self.checkin && self.checkout && self.checkin >= self.checkout 
      self.errors.add(:reservation, "invalid checkin and checkout dates")
    end 
  end
  
  def not_your_listing 
    if self.listing.host == self.guest 
      errors.add(:reservation, "guest and host can't be the same")
    end 
  end 

  def listing_available
    # Check for nil values 
    return if self.checkin.nil? || self.checkout.nil? 

    # Get a list of all available listing_ids 
    available_by_id = self.listing.neighborhood.neighborhood_openings(checkin.to_s, checkout.to_s).map {|listing| listing.id}
    
    if !available_by_id.include?(self.listing_id)
      errors.add(:reservation, "already booked")
    end 
  end 

  def duration 
    (self.checkout - self.checkin).to_i 
  end 

  def total_price 
    duration * self.listing.price 
  end 
end
