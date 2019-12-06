module Error
    module ErrorHandler 
        
        def self.included(clazz)
            clazz.class_eval do
                rescue_from StandardError, with: :handle_argument_error
            end
        end

        private 

        def handle_argument_error(e) 
            render json: { error: e.to_s } , status: :internal_server_error
        end

    end
end