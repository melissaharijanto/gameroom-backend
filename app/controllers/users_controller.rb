class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
  # before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users, status: :ok
  end

  # GET /users/1
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
      @user = User.new(user_params)
      @user.save

        if @user.valid?
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 1.week.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                          user: @user.as_json(except: [:password_digest, :created_at, :updated_at]) }, status: :ok
        else
          render json: @user.errors.full_messages, status: :unauthorized
        end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    def find_user
      @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    # # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
