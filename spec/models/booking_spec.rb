require 'rails_helper'

RSpec.describe Booking, type: :model do
  
  let(:region_one) do
      Region.new(id: '1', name: 'INDIA', region_type: 'COUNTRY')
  end 

  let(:theatre_one) do
      Theatre.new(name: 'T1', address: 'A1',region: region_one)
  end

  let(:hall_one) do
    Hall.new(name: 'H1', seats: 10, theatre: theatre_one)
  end

end
