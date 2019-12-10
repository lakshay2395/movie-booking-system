# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    {
      "first_name": 'Lakshay',
      "last_name": 'Bhambri',
      "email_id": 'bhambri@gmail.com',
      "password": '1234'
    }
  end

  let(:users) do
    [
      User.new(
        id: '1',
        first_name: 'Lakshay',
        last_name: 'Bhambri',
        email_id: 'bhambri.lakshay@gmail.com',
        password: '1234'
      ),
      User.new(
        id: '2',
        first_name: 'Srishty',
        last_name: 'Bhambri',
        email_id: 'srishty1@gmail.com',
        password: '1234'
      )
    ]
  end

  before do
    items = users
    items.each(&:save!)
  end

  describe 'GET /users' do
    it 'should run' do
      expect(User).to receive(:all).and_return(users)
      get :index
      expect(response.status).to eq(200)
      expect(response.body).to eq(users.to_json)
    end
  end

  describe 'GET /users/{id}' do
    it 'should run' do
      expect(User).to receive(:find_by).and_return([user])
      get :show, params: { id: 1 }
      expect(response.status).to eq(200)
      expect(response.body).to eq([user].to_json)
    end

    it 'should not run' do
      get :show, params: { id: 5 }
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /users' do
    context 'success' do
      it 'should run' do
        post :create, params: user
        expect(response.status).to eq(201)
        user_body = JSON.parse(response.body)
        expect(user_body['first_name']).to eq('Lakshay')
        expect(user_body['last_name']).to eq('Bhambri')
        expect(user_body['email_id']).to eq('bhambri@gmail.com')
        expect(user_body['password']).to eq('1234')
      end
    end

    context 'failure' do
      it 'should not run because of duplicate id' do
        item = user
        user['email_id'] = 'bhambri.lakshay@gmail.com'
        post :create, params: user
        expect(response.status).to eq(500)
        expect(JSON.parse(response.body)['error']['email_id']).to eq(['has already been taken'])
      end
    end
  end

  describe 'PUT /users/id' do
    context 'success' do
      it 'should run' do
        item = user
        item[:id] = 1
        item[:email_id] = 'bhambri@gmail.com'
        put :update, params: item
        expect(response.status).to eq(200)
        user_body = JSON.parse(response.body)
        expect(user_body['first_name']).to eq('Lakshay')
        expect(user_body['last_name']).to eq('Bhambri')
        expect(user_body['email_id']).to eq('bhambri@gmail.com')
        expect(user_body['password']).to eq('1234')
      end
    end

    context 'failure' do
      it 'should not run' do
        item = user
        item[:id] = 4
        item[:email_id] = 'bhambri@gmail.com'
        put :update, params: item
        expect(response.status).to eq(405)
      end

      it 'should not run because of duplicate id' do
        item = user
        item[:id] = 2
        item[:email_id] = 'bhambri.lakshay@gmail.com'
        put :update, params: item
        expect(response.status).to eq(405)
      end
    end
  end

  describe 'DELETE /users/{id}' do
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
