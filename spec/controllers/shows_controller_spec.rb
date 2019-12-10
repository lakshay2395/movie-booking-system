# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe ShowsController, type: :controller do
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

  let(:timing_two) do
    Timing.new(
      "id": 2,
      "name": 'T2',
      "start_time": '08:00:00',
      "end_time": '11:00:00'
    )
  end

  let(:timing_three) do
    Timing.new(
      "id": 3,
      "name": 'T3',
      "start_time": '09:00:00',
      "end_time": '12:00:00'
    )
  end

  let(:show) do
    {
      "id": 1,
      "movie_id": 1,
      "hall_id": 1,
      "timing_id": timing_three,
      "show_date": '2019-02-02',
      "seat_price": 10,
      "available_seats": 10
    }
  end

  let(:shows) do
    [
      Show.new(
        "id": 1,
        "movie": movie,
        "hall": hall,
        "timing": timing_one,
        "show_date": '2019-02-02',
        "seat_price": 10,
        "available_seats": 10
      ),
      Show.new(
        "id": 2,
        "movie": movie,
        "hall": hall,
        "timing": timing_two,
        "show_date": '2019-02-02',
        "seat_price": 10,
        "available_seats": 10
      )
    ]
  end

  before do
    region.save!
    theatre.save!
    hall.save!
    movie.save!
    movie_two.save!
    timing_one.save!
    timing_two.save!
    timing_three.save!
    items = shows
    items.each(&:save!)
  end

  describe 'GET /shows' do
    it 'should run' do
      get :index, params: { region_id: region.id, theatre_id: theatre.id, hall_id: hall.id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).length).to eq(2)
    end
  end

  describe 'GET /shows/{id}' do
    it 'should run' do
      get :show, params: { region_id: region.id, theatre_id: theatre.id, id: 1, hall_id: hall.id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['movie_id']).to eq(1)
    end

    it 'should not run' do
      get :show, params: { region_id: region.id, theatre_id: theatre.id, id: 5, hall_id: hall.id }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /shows' do
    context 'success' do
      it 'should run' do
        item = show
        item['region_id'] = 1
        item[:theatre_id] = 1
        item[:hall_id] = 1
        item[:movie_id] = 1
        post :create, params: item
        expect(response.status).to eq(201)
        show_body = JSON.parse(response.body)
        expect(show_body['movie_id']).to eq(1)
      end
    end
  end

  describe 'PUT /shows/id' do
    context 'success' do
      it 'should run' do
        item = show
        item[:id] = 1
        item['region_id'] = 1
        item[:theatre_id] = 1
        item[:hall_id] = 1
        item[:movie_id] = 2
        put :update, params: item
        expect(response.status).to eq(200)
        show_body = JSON.parse(response.body)
        expect(show_body['movie_id']).to eq(2)
      end
    end

    context 'failure' do
      it 'should not run' do
        item = show
        item[:id] = 4
        item['region_id'] = 1
        item[:theatre_id] = 1
        item[:hall_id] = 1
        item[:movie_id] = 2
        put :update, params: item

        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /shows/{id}' do
    it 'should run' do
      delete :destroy, params: { id: 1, region_id: region.id, theatre_id: theatre.id, hall_id: hall.id }
      expect(response.status).to eq(204)
    end

    it 'should not run' do
      delete :destroy, params: { id: 5, region_id: region.id, theatre_id: theatre.id, hall_id: hall.id }
      expect(response.status).to eq(405)
    end
  end
end
