class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
#    if params[:sorted_by]==nil
#      @movies = Movie.all
#    else
#      @movies = Movie.order(params[:sorted_by])
#      @selected_col = params[:sorted_by]
#    end

    if params[:sorted_by]==nil
      if params[:ratings]
        @movies = Movie.where({rating: params[:ratings].keys})
      else
        @movies = Movie.all
      end 
    else
      if params[:ratings]
        @movies = Movie.where({rating: params[:ratings].keys}).order(params[:sorted_by])
        @selected_col = params[:sorted_by]
      else
        @movies = Movie.order(params[:sorted_by])
        @selected_col = params[:sorted_by]
      end
    end
    @all_ratings = Movie.returnRatings
    
    
    @checked_ratingboxes = params[:ratings]
    if @checked_ratingboxes
      @flag=false   #check whether this is the first load of page. Hash for rating_boxes=NULL
    else
      @flag=true    #create a new Hash for rating boxes
      @checked_ratingboxes = Hash.new 
    end
      
      
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
