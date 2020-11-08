class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    fascade = ForecastFacade.get_forecast(location)
    render json: ForecastSerializer.new(fascade)
  end
end
