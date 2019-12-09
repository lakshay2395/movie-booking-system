class TimingsController < ApplicationController
    
    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_timing }, only: [:show, :destroy, :update] 
    before_action -> { update_timing_details_before_save }, only: [:update]

    TIMING_NOT_FOUND = 'No timing found for id %s'.freeze

    def index
        index_model(@timings)
    end

    def show
        show_model(@timing, TIMING_NOT_FOUND % [id], :not_found)
    end

    def create
       timing = Timing.new(name: name, start_time: start_time, end_time: end_time) 
       create_or_update_model(timing)
    end

    def destroy
        destroy_model(@timing, TIMING_NOT_FOUND % [id], :not_found)
    end 

    def update
        create_or_update_model(@timing)
    end

    private

    def id
        params[:id]
    end

    def name
        params[:name]
    end

    def start_time
        params[:start_time]
    end

    def end_time
        params[:end_time]
    end

    def fetch_timing
        @timing = Timing.find_by(id: id)
    end

    def fetch_all
        @timings = Timing.all
    end

    def update_timing_details_before_save
        @timing.name = name
        @timing.start_time = start_time
        @timing.end_time = end_time
    end
    
end