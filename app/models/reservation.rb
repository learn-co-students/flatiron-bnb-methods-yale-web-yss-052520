class Reservation < ActiveRecord::Base
  belongs_to :listing  
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true 
  validates :checkout, presence: true 
  validate :is_host_not_guest?
  validate :is_checkin_available?  
  validate :is_checkout_available? 
  validate :is_checkout_after_checkin?


  def res_in_dates(start,finish)
    # checks if reservation is between start and finish dates 
    if self.checkin <= start && self.checkout >= start 
      return true 
    elsif  self.checkin >= start && self.checkout <= finish  
      return true 
    elsif self.checkin <= finish && self.checkout >= finish
      return true  
    end 
    return false  
  end 

  def duration 
    self.checkout - self.checkin 
  end 

  def total_price 
    self.duration * self.listing.price  
  end 

  private 

  def is_checkin_available?
    if self.checkin 
      if self.listing.free_in_dates(self.checkin,self.checkin) 
        return true 
      else 
        errors.add(:checkin, "not valid checkin")
      end 
    end 
  end 

  def is_checkout_available?
    if self.checkout
      if self.listing.free_in_dates(self.checkout,self.checkout) 
        return true 
      else 
        errors.add(:checkout, "not valid checkout")
      end 
    end 
  end 

  def is_checkout_after_checkin?
    if self.checkout && self.checkin 
      if self.checkout <= self.checkin 
        errors.add(:checkout, "check in before out!")
      end 
    end 
  end 

  def is_host_not_guest? 
    if self.listing.host == self.guest 
      errors.add(:guest_id, "host can't stay in own listing")
    end 
    return true 
  end 

end
