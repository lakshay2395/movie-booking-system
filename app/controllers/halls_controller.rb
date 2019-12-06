class HallsController < TheatresController

    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_hall }, only: [:show, :destroy, :update] 
    before_action -> { update_hall_details_before_save }, only: [:update]

    HALL_NOT_FOUND = 'No hall found for id %s'.freeze

    def index
        render json: @halls, status: :ok
    end

    def show
        if @hall
            render json: @hall, status: :ok
        else
            handle_error(HALL_NOT_FOUND % [id],:not_found)
        end
    end

    def create
       hall = Hall.new(name: name, seats: seats, theatre: theatre) 
       if hall.valid?
            hall.save! 
            render json: hall, status: :created
       else
            handle_error(hall.errors.messages,:internal_server_error)
       end
    end

    def destroy
        if @hall
            @hall.destroy!
            render json: nil, status: :no_content
        else
            handle_error(HALL_NOT_FOUND % [id],:not_found)
        end
    end 

    def update
        if @hall.valid?
            @hall.save!
            render json: @hall, status: :ok
        else 
            handle_error(@hall.errors.messages,:internal_server_error)
        end
    end

    private

    def seats
        params[:seats]
    end

    def theatre
        Theatre.find_by(id: theatre_id)
    end

    def theatre_id
        params[:theatre_id]
    end

    def fetch_hall
        @hall = Hall.find_by(id: id)
    end

    def fetch_all
        @halls = Hall.all
    end

    def update_hall_details_before_save
        @hall.name = name
        @hall.seats = seats
        @hall.theatre = theatre
    end
    
end