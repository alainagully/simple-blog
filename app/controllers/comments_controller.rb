class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]
  before_action :authenticate_user!, except: [:show, :index]
  
  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment succesfully added" }
        format.js { render :create_success }
      else
        format.html {
          flash[:alert] = "Invalid input!"
          render "/posts/show" }
        format.js { render :create_failure }
      end
    end

  end

  def edit
    render json: params
  end

  def update
    render json: params    
  end
  
  def destroy
    unless can? :destroy, @comment
      redirect_to index_path, alert: "Access denied"
    else
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post) }
        format.js { render }
      end

    end
  end
  
  private

  def find_comment
    @comment = Comment.find params[:id]
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
