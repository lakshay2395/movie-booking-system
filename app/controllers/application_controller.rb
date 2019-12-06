class ApplicationController < ActionController::API
    include Error::ErrorHandler

    def handle_error(error,status)
        render json: { error: error }, status: status
    end
end
