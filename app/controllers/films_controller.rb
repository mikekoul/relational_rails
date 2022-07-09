class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
  end

  def update
    film = Film.find(params[:id])
    film.update(film_params)
    redirect_to "/films/#{film.id}"
  end

  def film_params
    params.permit(:name, :runtime, :streaming_on_netflix)
  end
end