class ApplicationController < ActionController::API
    before_action :authenticate_request

    attr_reader :current_user
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    
    private
    
    def authenticate_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header

        if token.nil?
            return render json: { error: 'Unauthorized: No token provided' }, status: :unauthorized
        end

        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id]) if decoded

    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        render json: { error: 'Unauthorized: Invalid token' }, status: :unauthorized
    end

    def handle_parameter_missing(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
    end
end
