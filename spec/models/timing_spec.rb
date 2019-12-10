# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timing, type: :model do
  let(:timing_one) do
    Timing.new(name: 'Timing One', start_time: '06:00:00', end_time: '08:00:00')
  end

  let(:timing_two) do
    Timing.new(name: 'Timing Two', start_time: '07:00:00', end_time: '09:00:00')
  end

  it 'is valid with valid attributes' do
    expect(timing_one).to be_valid
  end

  it 'is not valid without start_time' do
    expect(Timing.new(start_time: nil)).to_not be_valid
  end

  it 'is not valid without end_time' do
    expect(Timing.new(end_time: nil)).to_not be_valid
  end
end
