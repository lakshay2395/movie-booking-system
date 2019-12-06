class TimingsController < ApplicationController
    
    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_timing }, only: [:show, :destroy, :update] 
    before_action -> { update_timing_details_before_save }, only: [:update]

    TIMING_NOT_FOUND = 'No timing found for id %s'.freeze

    def index
        render json: @timings, status: :ok
    end

    def show
        if @timing
            render json: @timing, status: :ok
        else
            handle_error(TIMING_NOT_FOUND % [id],:not_found)
        end
    end

    def create
       timing = Timing.new(name: name, start_time: start_time, end_time: end_time) 
       if timing.valid?
            timing.save! 
            render json: timing, status: :created
       else
            handle_error(timing.errors.messages,:internal_server_error)
       end
    end

    def destroy
        if @timing
            @timing.destroy!
            render json: nil, status: :no_content
        else
            handle_error(TIMING_NOT_FOUND % [id],:not_found)
        end
    end 

    def update
        if @timing.valid?
            @timing.save!
            render json: @timing, status: :ok
        else 
            handle_error(@timing.errors.messages,:internal_server_error)
        end
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