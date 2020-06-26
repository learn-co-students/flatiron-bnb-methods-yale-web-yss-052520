class ReviewValidator < ActiveModel::Validator
    def validate(record)  
        if record.reservation
            # byebug
            if (Date.today < record.reservation.checkout)
                record.errors.add :base, 'Cannot leave a review before checking out'
            elsif !(record.reservation.status == 'accepted')
                record.errors.add :base, 'Reservation needs to have been accepted'
            else
                return
            end
        else
            record.errors.add :base, 'No Reservation!'
        end
    end
end