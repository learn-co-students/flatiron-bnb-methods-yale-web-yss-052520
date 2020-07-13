class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, presence: true
  validates :description, presence: true
  validates :reservation, presence: true

  validate :reservation_checkedout

  def reservation_checkedout
    if reservation && reservation.checkout > Time.now
      errors.add(:reservation, "must have already happened")
    end
  end
end
