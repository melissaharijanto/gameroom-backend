class GameCommunitiesController < ApplicationController
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_community
      @game_community = GameCommunity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_community_params
      params.require(:game_community).permit(:title, :image_url, :followers)
    end
end
