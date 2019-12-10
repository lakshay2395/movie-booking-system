# frozen_string_literal: true

class HallsController < TheatresController
  before_action -> { fetch_all }, only: [:index]
  before_action -> { fetch_hall }, only: %i[show destroy update]
  before_action -> { update_hall_details_before_save }, only: [:update]

  HALL_NOT_FOUND = 'No hall found for id %s'

  def index
    index_model(@halls)
  end

  def show
    show_model(@hall, format(HALL_NOT_FOUND, id), :not_found)
  end

  def create
    hall = Hall.new(name: name, seats: seats, theatre: theatre)
    create_model(hall)
  end

  def destroy
    destroy_model(@hall, format(HALL_NOT_FOUND, id), :method_not_allowed)
  end

  def update
    update_model(@hall, format(HALL_NOT_FOUND, id), :method_not_allowed)
  end

  private

  def seats
    params[:seats]
  end

  def theatre
    Theatre.find_by!(id: theatre_id)
  end

  def theatre_id
    params[:theatre_id]
  end

  def fetch_hall
    @hall = Hall.find_by(id: id)
  end

  def fetch_all
    @halls = Hall.where(theatre: theatre)
  end

  def update_hall_details_before_save
    if @hall
      @hall.name = name
      @hall.seats = seats
      @hall.theatre = theatre
    end
  end
end
