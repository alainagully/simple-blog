class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, except: [:index]

  def index
    @favourite_posts = current_user.favourited_posts
  end
  
  def create
    favourite = Favourite.new(user: current_user, post: @post)
    respond_to do |format|
      if favourite.save
        format.html { redirect_to post_path(@post), notice: "Post added to favourites." }
        format.js { render :create_success }
      else
        format.html { redirect_to post_path(@post), notice: "You have already added this post to your favourites!" }
        format.js { render :create_failure }
      end      
    end
  end

  def destroy
    @favourite = Favourite.find params[:id]
    @favourite.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Post removed from favourites." }
      format.js { render }
    end

  end
  
  private

  def find_post
    @post = Post.find params[:post_id]
  end
end
