class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :description, presence: true
  validates :rating, presence: true
  validates :reservation, presence: true

  validate :valid_review, :accepted

  private 

  def valid_review()
    if reservation && reservation.checkout > Date.today
      errors.add(:reservation, "Must be checkout")
    end
  end

  def accepted()
    if reservation && reservation.status != "accepted"
      errors.add(:reservation, "Must be accepted")
    end
  end
end
