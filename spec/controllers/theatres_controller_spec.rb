# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe TheatresController, type: :controller do
  let(:region) do
    Region.new(
      "id": 1,
      "name": 'R3',
      "region_type": 'COUNTRY',
      "parent_id": nil
    )
  end

  let(:theatre) do
    {
      "id": 3,
      "name": 'T3',
      "address": 'A3',
      "region_id": 1
    }
  end

  let(:theatres) do
    [
      Theatre.new(
        "id": 1,
        "name": 'T1',
        "address": 'A1',
        "region": region
      ),
      Theatre.new(
        "id": 2,
        "name": 'T2',
        "address": 'A2',
        "region": region
      )
    ]
  end

  before do
    region.save!
    items = theatres
    items.each(&:save!)
  end

  describe 'GET /theatres' do
    it 'should run' do
      get :index, params: { region_id: region.id }
      expect(response.status).to eq(200)
      expect(response.body).to eq(theatres.to_json)
    end
  end

  describe 'GET /theatres/{id}' do
    it 'should run' do
      get :show, params: { region_id: region.id, id: 1 }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq('T1')
    end

    it 'should run' do
      get :show, params: { region_id: region.id, id: 5 }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /theatres' do
    context 'success' do
      it 'should run' do
        item = theatre
        theatre[:region_id] = 1
        post :create, params: theatre
        expect(response.status).to eq(201)
        theatre_body = JSON.parse(response.body)
        expect(theatre_body['name']).to eq('T3')
      end
    end
  end

  describe 'PUT /theatres/id' do
    context 'success' do
      it 'should run' do
        item = theatre
        item[:id] = 1
        item[:name] = 'T11'
        put :update, params: item
        expect(response.status).to eq(200)
        theatre_body = JSON.parse(response.body)
        expect(theatre_body['name']).to eq('T11')
      end
    end

    context 'failure' do
      it 'should not run' do
        item = theatre
        item[:id] = 4
        put :update, params: item

        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /theatres/{id}' do
    it 'should run' do
      delete :destroy, params: { id: 1, region_id: region.id }
      expect(response.status).to eq(204)
    end

    it 'should not run' do
      delete :destroy, params: { id: 5, region_id: region.id }
      expect(response.status).to eq(405)
    end
  end
end
