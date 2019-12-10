# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe BookingsController, type: :controller do
  let(:user) do
    User.new(
      "id": 1,
      "first_name": 'Lakshay',
      "last_name": 'Bhambri',
      "email_id": 'bhambri@gmail.com',
      "password": '1234'
    )
  end

  let(:hall) do
    Hall.new(
      "id": 1,
      "name": 'H1',
      "theatre": theatre,
      "seats": 10
    )
  end

  let(:theatre) do
    Theatre.new(
      "id": 1,
      "name": 'T1',
      "address": 'A3',
      "region": region
    )
  end

  let(:region) do
    Region.new(
      "id": 1,
      "name": 'R3',
      "region_type": 'COUNTRY',
      "parent": nil
    )
  end

  let(:movie) do
    Movie.new(
      "id": 1,
      "name": 'M1',
      "director_name": 'D1',
      "release_date": '2019-02-02',
      "is_active": false
    )
  end

  let(:movie_two) do
    Movie.new(
      "id": 2,
      "name": 'M2',
      "director_name": 'D2',
      "release_date": '2019-02-02',
      "is_active": false
    )
  end

  let(:timing_one) do
    Timing.new(
      "id": 1,
      "name": 'T1',
      "start_time": '07:00:00',
      "end_time": '10:00:00'
    )
  end

  let(:show) do
    Show.new(
      "id": 1,
      "movie_id": 1,
      "hall_id": 1,
      "timing_id": 1,
      "show_date": '2019-02-02',
      "seat_price": 10,
      "available_seats": 10
    )
  end

  let(:booking) do
    {
      user_id: 1,
      show_id: 1,
      seats: 1
    }
  end

  let(:bookings) do
    [
      Booking.new(
        user: user,
        show: show,
        seats: 2
      ),
      Booking.new(
        user: user,
        show: show,
        seats: 3
      )
    ]
  end

  before do
    user.save!
    timing_one.save!
    hall.save!
    theatre.save!
    region.save!
    movie.save!
    movie_two.save!
    user.save!
    show.save!
    items = bookings
    items.each(&:save!)
  end

  describe 'GET /bookings' do
    it 'should run' do
      get :index, params: { region_id: region.id, theatre_id: theatre.id, hall_id: hall.id, show_id: show.id }
      expect(response.status).to eq(200)
      expect(response.body).to eq(bookings.to_json)
    end
  end

  describe 'GET /bookings/{id}' do
    it 'should run' do
      get :show, params: { id: 1, region_id: region.id, theatre_id: theatre.id, hall_id: hall.id, show_id: show.id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['user_id']).to eq(1)
      expect(JSON.parse(response.body)['show_id']).to eq(1)
    end

    it 'should not run' do
      get :show, params: { id: 5, region_id: region.id, theatre_id: theatre.id, hall_id: hall.id, show_id: show.id }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /bookings' do
    context 'success' do
      it 'should run' do
        item = booking
        post :create, params: booking
        expect(response.status).to eq(201)
        booking_body = JSON.parse(response.body)
        expect(booking_body['show_id']).to eq(1)
        expect(booking_body['user_id']).to eq(1)
      end
    end

    context 'failure' do
      it 'should not run' do
        item = booking
        item['seats'] = 11
        post :create, params: booking
        expect(response.status).to eq(500)
      end
    end
  end

  describe 'PUT /bookings/id' do
    context 'success' do
      it 'should run' do
        item = booking
        item[:id] = 1
        item[:theatre_id] = 1
        put :update, params: item
        booking_body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(booking_body['show_id']).to eq(1)
        expect(booking_body['user_id']).to eq(1)
      end
    end

    context 'failure' do
      it 'should not run' do
        item = booking
        item[:id] = 4
        item[:show_id] = 1
        put :update, params: item

        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /bookings/{id}' do
    it 'should run' do
      delete :destroy, params: { id: 1, show_id: 1 }
      expect(response.status).to eq(204)
    end

    it 'should not run' do
      delete :destroy, params: { id: 5, show_id: 1 }
      expect(response.status).to eq(405)
    end
  end
end
