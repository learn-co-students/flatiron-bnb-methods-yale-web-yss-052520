class ReservationValidator < ActiveModel::Validator
    def validate(record)
      if record.listing.host == record.guest
        record.errors.add :base, 'Host cannot be same as guest'
      end
      if record.checkin && record.checkout
        if !record.listing.reservations.empty? && record.listing.reservations.reject{|r| r==record}.find {|res| record.checkout.between?(res.checkin, res.checkout) || record.checkin.between?(res.checkin, res.checkout) }
            # byebug
            record.errors.add :base, 'There is another reservation during that time'
        end
        if record.checkin >= record.checkout
            record.errors.add :base, 'Checkin must be after Checkout'
        end
      end
    end
end