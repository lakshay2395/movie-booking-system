# frozen_string_literal: true

class TheatresController < RegionsController
  before_action -> { fetch_all }, only: [:index]
  before_action -> { fetch_theatre }, only: %i[show destroy update]
  before_action -> { update_theatre_details_before_save }, only: [:update]

  THEATRE_NOT_FOUND = 'No theatre found for id %s'

  def index
    index_model(@theatres)
  end

  def show
    show_model(@theatre, format(THEATRE_NOT_FOUND, id), :not_found)
  end

  def create
    theatre = Theatre.new(name: name, address: address, region: region)
    create_model(theatre)
  end

  def destroy
    destroy_model(@theatre, format(THEATRE_NOT_FOUND, id), :method_not_allowed)
  end

  def update
    update_model(@theatre, format(THEATRE_NOT_FOUND, id), :method_not_allowed)
  end

  private

  def address
    params[:address]
  end

  def region_id
    params[:region_id]
  end

  def region
    Region.find_by(id: region_id)
  end

  def fetch_theatre
    @theatre = Theatre.find_by(id: id)
  end

  def fetch_all
    @theatres = Theatre.where(region: region)
  end

  def update_theatre_details_before_save
    if @theatre
      @theatre.name = name
      @theatre.address = address
      @theatre.region = region
    end
  end
end
