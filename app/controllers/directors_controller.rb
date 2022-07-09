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

  
  def edit
    @director = Director.find(params[:id])
  end
  
  def update
    director = Director.find(params[:id])
    director.update(director_params)
    redirect_to "/directors/#{director.id}"
  end
  
  def show
    @director = Director.find(params[:id])
  end

  private
  def director_params
    params.permit(:name, :academy_awards, :deceased)
  end
end