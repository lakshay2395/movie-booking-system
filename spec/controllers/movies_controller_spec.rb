# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe MoviesController, type: :controller do
  let(:movie) do
    {
      "name": 'M3',
      "director_name": 'D3',
      "release_date": '2019-02-02',
      "is_active": false
    }
  end

  let(:movies) do
    [
      Movie.new(
        "id": 1,
        "name": 'M1',
        "director_name": 'D1',
        "release_date": '2019-02-02',
        "is_active": false
      ),
      Movie.new(
        "id": 2,
        "name": 'M2',
        "director_name": 'D2',
        "release_date": '2019-02-02',
        "is_active": false
      )
    ]
  end

  before do
    items = movies
    items.each(&:save!)
  end

  describe 'GET /movies' do
    it 'should run' do
      expect(Movie).to receive(:all).and_return(movies)
      get :index
      expect(response.status).to eq(200)
      expect(response.body).to eq(movies.to_json)
    end
  end

  describe 'GET /movies/{id}' do
    it 'should run' do
      get :show, params: { id: 1 }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq('M1')
    end

    it 'should not run' do
      get :show, params: { id: 5 }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /movies' do
    context 'success' do
      it 'should run' do
        post :create, params: movie
        expect(response.status).to eq(201)
        movie_body = JSON.parse(response.body)
        expect(movie_body['name']).to eq('M3')
      end
    end
  end

  describe 'PUT /movies/id' do
    context 'success' do
      it 'should run' do
        item = movie
        item[:id] = 1
        item[:name] = 'M11'
        put :update, params: item
        expect(response.status).to eq(200)
        movie_body = JSON.parse(response.body)
        expect(movie_body['name']).to eq('M11')
      end
    end

    context 'failure' do
      it 'should not run' do
        item = movie
        item[:id] = 4
        put :update, params: item

        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /movies/{id}' do
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
