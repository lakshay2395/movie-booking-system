# frozen_string_literal: true

class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  belongs_to :timing
  validates :show_date, presence: true
  validates :seat_price, presence: true, numericality: { greater_than: 0 }

  before_create do |show|
    if show.available_seats > show.hall.seats
      raise ArgumentError, 'Available seats for the show cannot be more than seats in hall'
      end
  end
  before_update do |show|
    if show.available_seats > show.hall.seats
      raise ArgumentError, 'Available seats for the show cannot be more than seats in hall'
    end
    if show.available_seats <= 0
      raise ArgumentError, 'Available seats for the show cannot be less than zero'
    end
  end
end
