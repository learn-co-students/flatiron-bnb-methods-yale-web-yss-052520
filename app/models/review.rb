class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, presence: true 
  validates :description, presence: true 
  validates :reservation, presence: true 

  validate :has_stay_happened? 


  private 

  def has_stay_happened? 
    if self.reservation 
      if self.reservation.checkout > Date.today 
        errors.add(:reservation, "your stay isn't over!") 
      end 
    end 
  end 

end
