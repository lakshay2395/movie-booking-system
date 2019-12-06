class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  belongs_to :timing
  validates :show_date, presence: true 
  validates :seat_price, presence: true, :numericality => { :greater_than => 0}

  before_create { |show| raise ArgumentError,"Available seats for the show cannot be more than seats in hall" if show.available_seats > show.hall.seats }
  before_update { |show| raise ArgumentError,"Available seats for the show cannot be more than seats in hall" if show.available_seats > show.hall.seats }
end
