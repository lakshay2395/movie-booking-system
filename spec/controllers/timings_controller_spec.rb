# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe TimingsController, type: :controller do
  let(:timing) do
    {
      "name": 'T3',
      "start_time": '09:00:00',
      "end_time": '12:00:00'
    }
  end

  let(:timings) do
    [
      Timing.new(
        "id": 1,
        "name": 'T1',
        "start_time": '07:00:00',
        "end_time": '10:00:00'
      ),
      Timing.new(
        "id": 2,
        "name": 'T2',
        "start_time": '08:00:00',
        "end_time": '11:00:00'
      )
    ]
  end

  before do
    items = timings
    items.each(&:save!)
  end

  describe 'GET /timings' do
    it 'should run' do
      expect(Timing).to receive(:all).and_return(timings)
      get :index
      expect(response.status).to eq(200)
      expect(response.body).to eq(timings.to_json)
    end
  end

  describe 'GET /timings/{id}' do
    it 'should run' do
      get :show, params: { id: 1 }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq('T1')
    end

    it 'should not run' do
      get :show, params: { id: 5 }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /timings' do
    context 'success' do
      it 'should run' do
        post :create, params: timing
        expect(response.status).to eq(201)
        timing_body = JSON.parse(response.body)
        expect(timing_body['name']).to eq('T3')
      end
    end
  end

  describe 'PUT /timings/id' do
    context 'success' do
      it 'should run' do
        item = timing
        item['id'] = 1
        item[:name] = 'T11'
        put :update, params: item
        expect(response.status).to eq(200)
        timing_body = JSON.parse(response.body)
        expect(timing_body['name']).to eq('T11')
      end
    end

    context 'failure' do
      it 'should not run' do
        item = timing
        item[:id] = 4
        put :update, params: item
        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /timings/{id}' do
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
