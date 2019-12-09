class ApplicationController < ActionController::API
    include Error::ErrorHandler

    def handle_error(error,status)
        render json: { error: error }, status: status
    end

    def index_model(models) 
        render json: models, status: :ok
    end

    def create_or_update_model(model)
        if model.valid?
            model.save! 
            render json: model, status: :created
       else
            handle_error(model.errors.messages,:internal_server_error)
       end
    end

    def show_model(model,error_message,error_status)
        if @user
            render json: @user, status: :ok
        else
            handle_error(error_message,error_status)
        end
    end

    def destroy_model(model,error_message,error_status) 
        if model
            model.destroy!
            render json: nil, status: :no_content
        else
            handle_error(error_message,error_status)
        end
    end
end
