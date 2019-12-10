# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_one) do
    User.new(id: 100, first_name: 'Lakshay', last_name: 'Bhambri', email_id: 'bhambri@gmail.com', password: '1234')
  end

  let(:user_two) do
    User.new(id: 101, first_name: 'Srishty', last_name: 'Bhambri', email_id: 'srishty@gmail.com', password: '5678')
  end

  let(:user_with_duplicate_email) do
    User.new(id: 102, first_name: 'Lakshay', last_name: 'Bhambri', email_id: 'bhambri@gmail.com', password: '1234')
  end

  it 'is valid with valid attributes' do
    expect(user_one).to be_valid
  end

  it 'is not valid without email id' do
    user = User.new(email_id: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without password' do
    user = User.new(email_id: 'bhambri@gmail.com', password: nil)
    expect(user).to_not be_valid
  end

  it 'cannot have duplicate email id' do
    user_one.save
    expect { user_with_duplicate_email.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
