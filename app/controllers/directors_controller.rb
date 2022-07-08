class DirectorsController < ApplicationController
  def index
    @directors = Director.all.sort_by_datetime_created
  end

  def show
    @director = Director.find(params[:id])
  end
end