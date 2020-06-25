class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :description, :rating, :reservation, presence: true 
  validate :already_happened 

  def already_happened
    if self.reservation && self.reservation.checkout > Date.today
      errors.add(:review, "can't post review yet")
    end 
  end 
end
