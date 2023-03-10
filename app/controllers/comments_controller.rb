class CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      @post = Post.find_by_id(@comment.post_id)
      @post_comments = @post.comments << @comment.id
      @post.update_attribute(:comments, @post_comments)
      render json: @comment, status: :created, location: @comment
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @post = Post.find_by_id(@comment.post_id)
    @comments_array = @post.comments
    if @comments_array.include?(@comment.id)
      @comments_array.delete(@comment.id)
      @post.update_attribute(:comments, @comments_array)
      @comment.destroy
    end
  end

  # POST /comments
  def get_comments_by_post_id
    @comments = Comments.where(post_id: params[:post_id]).reverse_order
    render json: @comments, status: :ok
  end

  # POST /comment_likes
  def set_likes
    @comment = Comment.find_by_id(params[:id])
    @likes_array = @comment.likes

    if @likes_array.include?(@current_user.id)
      @likes_array.delete(@current_user.id)
      @comment.update_attribute(:likes, @likes_array)
      @comment.save
    else
      @likes_array << @current_user.id
      @comment.update_attribute(:likes, @likes_array)
      @comment.save
    end

    render json: @likes_array, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id, :username)
    end
end
