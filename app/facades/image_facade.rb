class ImageFacade
  def self.get_image(location)
    image_data = ImageService.location_image(location)
    Image.new(location, image_data)
  end
end
