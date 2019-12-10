# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Show, type: :model do
  let(:movie_one) do
    Movie.new(name: 'Lakshya', director_name: 'Rakesh Roshan', release_date: '2003-12-02', is_active: false)
  end

  let(:timing_one) do
    Timing.new(name: 'Timing Two', start_time: '07:00:00', end_time: '09:00:00')
  end

  let(:region_one) do
    Region.new(id: '1', name: 'INDIA', region_type: 'COUNTRY')
  end

  let(:theatre_one) do
    Theatre.new(name: 'T1', address: 'A1', region: region_one)
  end

  let(:hall_one) do
    Hall.new(name: 'H1', seats: 10, theatre: theatre_one)
  end

  let(:show_one) do
    Show.new(movie: movie_one, hall: hall_one, timing: timing_one, show_date: '2019-12-02', seat_price: 10, available_seats: 10)
  end

  it 'is valid with valid attributes' do
    expect(show_one).to be_valid
  end

  it 'is not valid without movie' do
    expect(Show.new(movie: nil, hall: hall_one, timing: timing_one, show_date: '2019-12-02', seat_price: 10, available_seats: 10)).to_not be_valid
  end

  it 'is not valid withoit hall' do
    expect(Show.new(movie: movie_one, hall: nil, timing: timing_one, show_date: '2019-12-02', seat_price: 10, available_seats: 10)).to_not be_valid
  end

  it 'is not valid withoit timing' do
    expect(Show.new(movie: movie_one, hall: hall_one, timing: nil, show_date: '2019-12-02', seat_price: 10, available_seats: 10)).to_not be_valid
  end

  it 'is not valid without show date' do
    expect(Show.new(movie: movie_one, hall: hall_one, timing: timing_one, show_date: nil, seat_price: 10, available_seats: 10)).to_not be_valid
  end

  it 'is not valid with seat price as 0' do
    expect(Show.new(movie: movie_one, hall: hall_one, timing: timing_one, show_date: '2019-12-02', seat_price: 0, available_seats: 10)).to_not be_valid
  end

  it 'is not valid with available seats more than hall seat count' do
    show = Show.new(movie: movie_one, hall: hall_one, timing: timing_one, show_date: '2019-12-02', seat_price: 10, available_seats: 11)
    expect { show.save! }.to raise_error(ArgumentError)
  end
end
