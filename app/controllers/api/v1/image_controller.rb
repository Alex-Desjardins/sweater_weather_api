class Api::V1::ImageController < ApplicationController
  def show
    location = params[:location]
    fascade = ImageFacade.get_image(location)
    render json: ImageSerializer.new(fascade)
  end
end
