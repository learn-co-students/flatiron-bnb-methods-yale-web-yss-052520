module Analyzable
    module InstanceMethods 
        def openings(start_date, end_date)
            # binding.pry
            start_date = Date.parse(start_date)
            end_date = Date.parse(end_date)
            open_listings = self.listings.select {|listing| 
                not_occupied(listing, start_date, end_date)
            }
            open_listings
        end 


        def total_reservations 
            self.listings.reduce(0) {|sum, listing| sum += listing.reservations.count }
        end 
    
        def reservations_per_listing
            num_reservations = total_reservations
            num_listings = self.listings.count 
            # need to check for division by zero 
            num_listings == 0 ? 0 : (num_reservations / num_listings.to_f)
        end
    
    
        private 
        def not_occupied(listing, checkin, checkout)
            associated_reservations = listing.reservations 
        
            # Only need to filter through reservations if this listing has any
            if !associated_reservations.empty?
                # select all reservations for this listing that overlap with the provided date range 
                associated_reservations = associated_reservations.select {|reservation| (reservation.checkin <= checkout && reservation.checkout >= checkin) }
            end 
            
            # only return true if there are no listings that overlap with the provided date range
            associated_reservations.size == 0 ? true : false
        end 
    end 
    
    module ClassMethods 
        def highest_ratio_res_to_listings
            # binding.pry
            self.all.max_by {|place| place.reservations_per_listing}
        end 

        def most_res 
            self.all.max_by {|place| place.total_reservations }
        end 
    end 
end 