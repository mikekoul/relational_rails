class DirectorsController < ApplicationController

  def index
    @directors = Director.all.sort_by_datetime_created
  end

  def new
  end

  def create
    director = Director.create!({
    name: params[:name],
    academy_awards: params[:academy_awards],
    deceased: params[:deceased]
    })
    redirect_to "/directors"
  end

  def show
    @director = Director.find(params[:id])
  end

end