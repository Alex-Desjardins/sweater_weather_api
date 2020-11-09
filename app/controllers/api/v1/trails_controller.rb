class Api::V1::TrailsController < ApplicationController
  def index
    location = params[:location]
    fascade = TrailFacade.get_trail(location)
    render json: TrailSerializer.new(fascade)
  end
end
