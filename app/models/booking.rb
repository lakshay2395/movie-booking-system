# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show

  before_create do |booking|
    booking_check(booking)
  end

  before_update do |booking|
    booking_check(booking)
  end

  def self.create_booking(booking)
    Booking.transaction do
      booking.save!
      booking.show.available_seats -= booking.seats
      booking.show.save!
    end
  end

  def self.update_booking(booking, seats)
    Booking.transaction do
      booking.show.available_seats += booking.seats
      booking.show.available_seats -= seats
      booking.show.save!
      booking.seats = seats
      booking.save!
    end
  end

  def self.delete_booking(booking)
    Booking.transaction do
      booking.show.available_seats += booking.seats
      booking.show.save!
      booking.destroy!
    end
  end

  private

  def booking_check(booking)
    if booking.seats > booking.show.available_seats
      raise ArgumentError, 'Seats for the booking cannot be more than the available seats for the show'
    end
    if booking.seats == 0
      raise ArgumentError, 'Seats for the booking cannot be 0'
    end
  end
end
