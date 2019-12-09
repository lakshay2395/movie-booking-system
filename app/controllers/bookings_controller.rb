class BookingsController < ShowsController
     
    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_booking }, only: [:show, :destroy, :update] 
    before_action -> { update_booking_details_before_save }, only: [:update]

    BOOKING_NOT_FOUND = 'No booking found for id %s for show with id %s'.freeze

    def index
        index_model(@bookings)
    end

    def show
        show_model(@booking,BOOKING_NOT_FOUND % [id, show_id],:not_found)
    end

    def create
       booking = Booking.new(show: show_data, user: user, seats: seats) 
       create_or_update_model(booking)
    end

    def destroy
        destroy_model(@booking,BOOKING_NOT_FOUND % [id, show_id],:not_found)
    end 

    def update
        create_or_update_model(@booking)
    end

    private

    def show_data
        Show.find_by(id: show_id)
    end

    def user
        User.find_by(id: user_id)
    end

    def seats
        params[:seats]
    end

    def show_id
        params[:show_id]
    end

    def user_id
        params[:user_id]
    end

    def fetch_booking
        @booking = Booking.find_by(show: show_data,id: id)
    end

    def fetch_all
        @bookings = Booking.where(show: show_data)
    end

    def update_booking_details_before_save
        @booking.user = user
        @booking.show = show_data
    end
         
end