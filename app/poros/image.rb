class Image
  attr_reader :id, :location, :url, :credit

  def initialize(location, image_data)
    @location = location
    @url = image_data[:url]
    @credit = {source: 'pexels.com',
               photographer: image_data[:photographer],
               photographer_url: image_data[:photographer_url]}
  end
end
