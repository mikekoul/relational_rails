class DirectorsController < ApplicationController

  def index
    @directors = Director.all.sort_by_datetime_created
  end

  def new
  end

  def create
    director = Director.create!(director_params)
    redirect_to "/directors"
  end

  def director_params
    params.permit(:name, :academy_awards, :deceased)
  end

  def show
    @director = Director.find(params[:id])
  end

end