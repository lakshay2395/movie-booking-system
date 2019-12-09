class ShowsController < HallsController
    
    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_show }, only: [:show, :destroy, :update] 
    before_action -> { update_show_details_before_save }, only: [:update]

    SHOW_NOT_FOUND = 'No show found for id %s'.freeze

    def index
        index_model(@shows)
    end

    def show
        show_model(@show,SHOW_NOT_FOUND % [id],:not_found)
    end

    def create
       show = Show.new(movie: movie, hall: hall, timing: timing, show_date: show_date, seat_price: seat_price, available_seats: available_seats) 
       create_or_update_model(show)
    end

    def destroy
        destroy_model(@show,SHOW_NOT_FOUND % [id],:not_found)
    end 

    def update
        create_or_update_model(@show)
    end

    private

    def movie
        Movie.find_by(id: movie_id)
    end

    def hall
        Hall.find_by(id: hall_id)
    end

    def timing
        Timing.find_by(id: timing_id)
    end

    def movie_id
        params[:movie_id]
    end

    def hall_id
        params[:hall_id]
    end

    def timing_id
        params[:timing_id]
    end

    def show_date
        params[:show_date]
    end
    
    def seat_price
        params[:seat_price]
    end

    def available_seats
        params[:available_seats]
    end

    def fetch_show
        @show = Show.find_by(id: id)
    end

    def fetch_all
        @shows = Show.where(hall: hall)
    end

    def update_show_details_before_save
        @show.movie = movie
        @show.hall = hall
        @show.timing = timing
        @show.show_date = show_date
        @show.seat_price = seat_price
        @show.available_seats = available_seats
    end
         
end