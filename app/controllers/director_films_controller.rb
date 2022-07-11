class DirectorFilmsController < ApplicationController
  def index
    @director = Director.find(params[:director_id])
    if params[:sort] == "alpha"
      @films = @director.films.sort_alphabetically
    else
      @films = @director.films
    end
  end

  def new
    @director = Director.find(params[:director_id])
  end

  def create
    @director = Director.find(params[:director_id])
    @director.films.create(film_params)
    redirect_to "/directors/#{@director.id}/films"
  end

  def film_params
    params.permit(:name, :runtime, :streaming_on_netflix)
  end
end