class PostsController < ApplicationController
  before_action: :authorize_request
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def get_posts_by_community_id
    @posts = Post.find(params[:game_community_id])
    render json: @posts, status: :ok
  end

  def set_likes
    @post = Post.find(params[:id])
    @likes_array = @post.likes

    if @likes_array.includes?(@current_user.id)
      @likes_array.delete(@current_user.id)
      @post.update_attribute(:likes, @likes_array)
      @post.save
    else
      @likes_array << @current_user.id
      @post.update_attribute(:likes, @likes_array)
      @post.save
    end

    render json: @likes_array, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :username, :comments, :user_id, :game_community_id)
    end
end
