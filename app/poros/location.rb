class Location
  attr_reader :coordinates, :city, :state, :country

  def initialize(data)
    @coordinates = data[:latLng]
    @city = data[:adminArea5]
    @state = data[:adminArea3]
    @country = data[:adminArea1]
  end
end
