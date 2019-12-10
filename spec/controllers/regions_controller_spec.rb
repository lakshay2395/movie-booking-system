# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe RegionsController, type: :controller do
  let(:region) do
    {
      "name": 'R3',
      "region_type": 'COUNTRY',
      "parent_id": nil
    }
  end

  let(:regions) do
    [
      Region.new(
        "id": 1,
        "name": 'R1',
        "region_type": 'COUNTRY',
        "parent": nil
      ),
      Region.new(
        "id": 2,
        "name": 'R2',
        "region_type": 'COUNTRY',
        "parent": nil
      )
    ]
  end

  before do
    items = regions
    items.each(&:save!)
  end

  describe 'GET /regions' do
    it 'should run' do
      expect(Region).to receive(:all).and_return(regions)
      get :index
      expect(response.status).to eq(200)
      expect(response.body).to eq(regions.to_json)
    end
  end

  describe 'GET /regions/{id}' do
    it 'should run' do
      get :show, params: { id: 1 }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq('R1')
    end

    it 'should not run' do
      get :show, params: { id: 5 }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /regions' do
    context 'success' do
      it 'should run' do
        post :create, params: region
        expect(response.status).to eq(201)
        region_body = JSON.parse(response.body)
        expect(region_body['name']).to eq('R3')
      end
    end
  end

  describe 'PUT /regions/id' do
    context 'success' do
      it 'should run' do
        item = region
        item[:id] = 1
        item[:name] = 'R11'
        put :update, params: item
        expect(response.status).to eq(200)
        region_body = JSON.parse(response.body)
        expect(region_body['name']).to eq('R11')
      end
    end

    context 'failure' do
      it 'should not run' do
        item = region
        item[:id] = 4
        put :update, params: item

        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /regions/{id}' do
    it 'should run' do
      delete :destroy, params: { id: 1 }
      expect(response.status).to eq(204)
    end

    it 'should not run' do
      delete :destroy, params: { id: 5 }
      expect(response.status).to eq(405)
    end
  end
end
