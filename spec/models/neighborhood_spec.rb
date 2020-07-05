describe Neighborhood do
  

  describe 'class methods' do
    describe ".highest_ratio_res_to_listings" do
      it 'knows the neighborhood with the highest ratio of reservations to listings' do 
        expect(Neighborhood.highest_ratio_res_to_listings).to eq(@nabe1)
      end
      
    end

    describe ".most_res" do
      it 'knows the neighborhood with the most reservations' do 
        expect(Neighborhood.most_res).to eq(@nabe1)
      end
      
    end 
  end
end
