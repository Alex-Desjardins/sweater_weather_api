class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: trip_params[:api_key])
    if user
      origin = trip_params[:origin]
      destination = trip_params[:destination]
      road_trip = RoadTripFacade.get_trip(origin, destination, user)
      render json: RoadTripSerializer.new(road_trip), status: 201
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
