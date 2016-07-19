class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Post successfully created."
    else
      flash[:alert] = "Invalid input."
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    redirect_to index_path, alert: "Access denied" unless can? :edit, @post
  end

  def update
    unless can? :update, @post
      redirect_to index_path, alert: "Access denied"
    else
      if @post.update post_params
        redirect_to post_path(@post)
      else
        render :edit
      end
    end
  end

  def destroy
 #   byebug
    unless can? :destroy, @post
      redirect_to index_path, alert: "Access denied"
    else
      @post.destroy
      redirect_to posts_path
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id, {tag_ids: []})
  end
end
