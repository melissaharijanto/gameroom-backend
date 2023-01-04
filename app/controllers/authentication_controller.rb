class AuthenticationController < ApplicationController
    before_action :authorize_request, except: [:login, :signup]

  # POST /auth/login
    def login
        @user = User.find_by_username(params[:username])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 1.week.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                          user: @user }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def current_user
      render json: @current_user, status: :ok
    end

  private

  def login_params
    params.permit(:username, :password)
  end
end
