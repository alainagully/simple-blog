class HomeController < ApplicationController

  def search
    @query = params[:q]
    @results = []
    if @query.empty?
      flash[:alert] =  "Your search query was empty!"
      render :search
    else
      @results << Post.where(["title ILIKE ? OR body ILIKE ?", "%#{@query}%",
                              "%#{@query}%"])
      @results << Comment.where(["body ILIKE ?", "%#{@query}%"])
      @results.flatten!
    end
  end

end
