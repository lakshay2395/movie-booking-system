require 'rails_helper'

RSpec.describe Theatre, type: :model do
  
    let(:region_one) do
        Region.new(id: '1', name: 'INDIA', region_type: 'COUNTRY')
    end 

    let(:theatre_one) do
        Theatre.new(name: 'T1', address: 'A1',region: region_one)
    end

    it "is valid with valid attributes" do 
        expect(theatre_one).to be_valid
    end

    it "is not valid without a name" do
        expect(Theatre.new(name: nil)).to_not be_valid
    end

    it "is not valid without address" do
        expect(Theatre.new(address: nil)).to_not be_valid
    end

    it "is not valid without region" do
        expect(Theatre.new(name: 'T2',address: 'A2',region: nil)).to_not be_valid
    end

end
