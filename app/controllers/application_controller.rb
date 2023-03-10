class ApplicationController < ActionController::API
    include JsonWebToken
    def not_found
        render json: { error: 'not_found' }
    end
    
    # JWT authentication taken from https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
    end
end
