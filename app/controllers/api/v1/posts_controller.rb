class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc)
    render json: @posts
  end
  
end
