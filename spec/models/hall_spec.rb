# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hall, type: :model do
  let(:region_one) do
    Region.new(id: '1', name: 'INDIA', region_type: 'COUNTRY')
  end

  let(:theatre_one) do
    Theatre.new(name: 'T1', address: 'A1', region: region_one)
  end

  let(:hall_one) do
    Hall.new(name: 'H1', seats: 10, theatre: theatre_one)
  end

  it 'is valid with valid attributes' do
    expect(hall_one).to be_valid
  end

  it 'is not valid without name' do
    expect(Hall.new(name: nil, seats: 10, theatre: theatre_one)).to_not be_valid
  end

  it 'is not valid without theatre' do
    expect(Hall.new(name: 'H1', seats: 10, theatre: nil)).to_not be_valid
  end

  it 'is not valid with 0 seats' do
    expect(Hall.new(name: 'H1', seats: 0, theatre: theatre_one)).to_not be_valid
  end
end
