class AuthController < ApplicationController
    skip_before_action :authenticate_request, only: [:login, :signup, :refresh]
    def login
        user = User.find_by(username: params[:username])
        
        if user&.authenticate(params[:password])
            access_token = JsonWebToken.encode({user_id: user.id}, 15.minutes.from_now)
            refresh_token = JsonWebToken.generate_refresh_token

            user.update(refresh_token: refresh_token)
            render json: {
                access_token: access_token,
                refresh_token: refresh_token
            }, status: :ok
        else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end

    def refresh
        refresh_token = params[:refresh_token]
        user = User.find_by(refresh_token: refresh_token)

        if user
            access_token = JsonWebToken.encode({ user_id: user.id }, 15.minutes.from_now)
            render json: { access_token: access_token }, status: :ok            
        else
            render json: { error: 'Invalid refresh token' }, status: :unauthorized
        end        
    end
    

    def signup
        user = User.new(username: params[:username], password: params[:password])
        
        if user.save
            render json: { message: 'User created successfully' }, status: :created 
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
        
    end
    
end
