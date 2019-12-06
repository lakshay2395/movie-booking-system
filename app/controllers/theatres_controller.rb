class TheatresController < RegionsController

    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_theatre }, only: [:show, :destroy, :update] 
    before_action -> { update_theatre_details_before_save }, only: [:update]

    THEATRE_NOT_FOUND = 'No theatre found for id %s'.freeze

    def index
        render json: @theatres, status: :ok
    end

    def show
        if @theatre
            render json: @theatre, status: :ok
        else
            handle_error(THEATRE_NOT_FOUND % [id],:not_found)
        end
    end

    def create
       theatre = Theatre.new(name: name, address: address, region: region) 
       if theatre.valid?
            theatre.save! 
            render json: theatre, status: :created
       else
            handle_error(theatre.errors.messages,:internal_server_error)
       end
    end

    def destroy
        if @theatre
            @theatre.destroy!
            render json: nil, status: :no_content
        else
            handle_error(THEATRE_NOT_FOUND % [id],:not_found)
        end
    end 

    def update
        if @theatre.valid?
            @theatre.save!
            render json: @theatre, status: :ok
        else 
            handle_error(@theatre.errors.messages,:internal_server_error)
        end
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
        @theatres = Theatre.all
    end

    def update_theatre_details_before_save
        @theatre.name = name
        @theatre.address = address
        @theatre.region = region
    end
    
end