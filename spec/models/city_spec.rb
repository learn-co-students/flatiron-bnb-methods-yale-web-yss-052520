describe City do
  

  describe 'class methods' do
    describe ".highest_ratio_res_to_listings" do
      it 'knows the city with the highest ratio of reservations to listings' do
        expect(City.highest_ratio_res_to_listings).to eq(City.find_by(:name => "NYC")) 
      end

     
    end

    describe ".most_res" do
      it 'knows the city with the most reservations' do
        expect(City.most_res).to eq(City.find_by(:name => "NYC")) 
      end 

     
    end
  end
end
