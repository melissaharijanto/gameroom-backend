class GameCommunitiesController < ApplicationController
  before_action :authorize_request, only: [:follow, :get_user_following]
  before_action :set_game_community, only: %i[ show update destroy ]

  # GET /game_communities
  def index
    @game_communities = GameCommunity.all

    render json: @game_communities
  end

  # GET /game_communities/1
  def show
    render json: @game_community
  end

  # POST /game_communities
  def create
    @game_community = GameCommunity.new(game_community_params)

    if @game_community.save
      render json: @game_community, status: :created, location: @game_community
    else
      render json: @game_community.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /game_communities/1
  def update
    if @game_community.update(game_community_params)
      render json: @game_community
    else
      render json: @game_community.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game_communities/1
  def destroy
    @game_community.destroy
  end

  def follow 
    @community = GameCommunity.find_by_id(params[:id])
    @followers_list = @community.followers
    if @community.followers.include?(@current_user.id)
      @followers_list.delete(@current_user.id)
      @community.update_attribute(:followers, @followers_list)
      @community.save
    else
      @followers_list << @current_user.id
      @community.update_attribute(:followers, @followers_list)
      @community.save
    end
    render json: @community.followers, status: :ok
  end

  def get_user_following
    @user_followings = []
    @communities = GameCommunity.all
    @communities.each do |community|
      @user_followings << community if community.followers.include?(@current_user.id)
    end
    render json: @user_followings
  end

  def search
    @title = params[:title]
    # SQL Query for case insensitive searches taken from https://stackoverflow.com/questions/30705898/rails-find-records-containing-specific-word
    @results = GameCommunity.where("lower(title) LIKE lower(?)", "%#{@title.downcase}%").take
    render json: @results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_community
      @game_community = GameCommunity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_community_params
      params.require(:game_community).permit(:title, :image_url, :icon_url)
    end
end
