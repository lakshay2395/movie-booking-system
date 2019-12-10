# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:user_one) do
    User.new(id: 100, first_name: 'Lakshay', last_name: 'Bhambri', email_id: 'bhambri.lakshay.lakshay@gmail.com', password: '1234')
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

  let(:movie_one) do
    Movie.new(name: 'M1', director_name: 'D1', release_date: '2019-12-10', is_active: true)
  end

  let(:timing_one) do
    Timing.new(name: 'Timing One', start_time: '07:00:00', end_time: '09:00:00')
  end

  let(:show_one) do
    Show.new(movie: movie_one, hall: hall_one, show_date: '2019-12-10', timing: timing_one, seat_price: 20, available_seats: 10)
  end

  let(:booking_one) do
    Booking.new(user: user_one, show: show_one, seats: 2)
  end

  before do
    movie_one.save!
    user_one.save!
    timing_one.save!
    region_one.save!
    theatre_one.save!
    hall_one.save!
    show_one.save!
  end

  describe 'test create_booking transaction' do
    it 'should run' do
      Booking.create_booking(booking_one)
      show = Show.find_by(id: show_one.id)
      expect(show_one.available_seats).to eq(8)
    end
  end

  describe 'test update_booking transaction' do
    it 'should run' do
      booking = booking_one
      Booking.create_booking(booking)
      Booking.update_booking(booking, 3)
      expect(show_one.available_seats).to eq(7)
    end
  end

  describe 'test delete_booking transaction' do
    it 'should run' do
      booking = booking_one
      Booking.create_booking(booking)

      Booking.delete_booking(booking)
      expect(show_one.available_seats).to eq(10)
    end
  end
end
