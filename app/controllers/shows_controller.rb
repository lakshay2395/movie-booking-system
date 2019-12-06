class ShowsController < HallsController
    
    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_show }, only: [:show, :destroy, :update] 
    before_action -> { update_show_details_before_save }, only: [:update]

    SHOW_NOT_FOUND = 'No show found for id %s'.freeze

    def index
        render json: @shows, status: :ok
    end

    def show
        if @show
            render json: @show, status: :ok
        else
            handle_error(SHOW_NOT_FOUND % [id],:not_found)
        end
    end

    def create
       show = Show.new(movie: movie, hall: hall, timing: timing, show_date: show_date, seat_price: seat_price, available_seats: available_seats) 
       if show.valid?
            show.save!
            render json: show, status: :created
       else
            handle_error(show.errors.messages,:internal_server_error)
       end
    end

    def destroy
        if @show
            @show.destroy!
            render json: nil, status: :no_content
        else
            handle_error(SHOW_NOT_FOUND % [id],:not_found)
        end
    end 

    def update
        if @show.valid?
            @show.save!
            render json: @show, status: :ok
        else 
            handle_error(@show.errors.messages,:internal_server_error)
        end
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
        @shows = Show.all
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