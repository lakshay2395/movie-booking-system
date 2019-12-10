# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Region, type: :model do
  let(:region_one) do
    Region.new(id: '1', name: 'INDIA', region_type: 'COUNTRY')
  end

  let(:region_two) do
    Region.new(id: '1', name: 'INDIA', region_type: 'AREA')
  end

  it 'is valid with valid attributes' do
    expect(region_one).to be_valid
  end

  it 'is not valid without name' do
    expect(Region.new(name: nil)).to_not be_valid
  end

  it 'is not valid without name' do
    expect(Region.new(region_type: nil)).to_not be_valid
  end

  it 'is not valid with incorrect region_type' do
    expect { region_two }.to raise_error(ArgumentError)
  end
end
