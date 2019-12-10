# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe HallsController, type: :controller do
  let(:region) do
    Region.new(
      "id": 1,
      "name": 'R3',
      "region_type": 'COUNTRY',
      "parent_id": nil
    )
  end

  let(:theatre) do
    Theatre.new(
      "id": 1,
      "name": 'T1',
      "address": 'A3',
      "region_id": 1
    )
  end

  let(:hall) do
    {
      "id": 3,
      "name": 'H3',
      "theatre": theatre,
      "seats": 10
    }
  end

  let(:halls) do
    [
      Hall.new(
        "id": 1,
        "name": 'H1',
        "theatre": theatre,
        "seats": 10
      ),
      Hall.new(
        "id": 2,
        "name": 'H2',
        "theatre": theatre,
        "seats": 10
      )
    ]
  end

  before do
    region.save!
    theatre.save!
    items = halls
    items.each(&:save!)
  end

  describe 'GET /halls' do
    it 'should run' do
      get :index, params: { region_id: region.id, theatre_id: theatre.id }
      expect(response.status).to eq(200)
      expect(response.body).to eq(halls.to_json)
    end
  end

  describe 'GET /halls/{id}' do
    it 'should run' do
      get :show, params: { region_id: region.id, theatre_id: theatre.id, id: 1 }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq('H1')
    end

    it 'should not run' do
      get :show, params: { region_id: region.id, theatre_id: theatre.id, id: 5 }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /halls' do
    context 'success' do
      it 'should run' do
        item = hall
        item['region_id'] = 1
        item[:theatre_id] = 1
        post :create, params: item
        expect(response.status).to eq(201)
        theatre_body = JSON.parse(response.body)
        expect(theatre_body['name']).to eq('H3')
      end
    end
  end

  describe 'PUT /halls/id' do
    context 'success' do
      it 'should run' do
        item = hall
        item[:id] = 1
        item['region_id'] = 1
        item[:theatre_id] = 1
        item[:name] = 'H11'
        put :update, params: item
        expect(response.status).to eq(200)
        theatre_body = JSON.parse(response.body)
        expect(theatre_body['name']).to eq('H11')
      end
    end

    context 'failure' do
      it 'should not run' do
        item = hall
        item[:id] = 4
        item['region_id'] = 1
        item[:theatre_id] = 1
        put :update, params: item

        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /halls/{id}' do
    it 'should run' do
      delete :destroy, params: { id: 1, region_id: region.id, theatre_id: theatre.id }
      expect(response.status).to eq(204)
    end

    it 'should not run' do
      delete :destroy, params: { id: 5, region_id: region.id, theatre_id: theatre.id }
      expect(response.status).to eq(405)
    end
  end
end
