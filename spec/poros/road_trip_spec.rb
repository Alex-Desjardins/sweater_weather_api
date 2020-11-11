require 'rails_helper'

RSpec.describe Forecast do
  it 'has attributes' do
    VCR.use_cassette('Telluride trip poro') do
      user = User.create(email: 'me@user.com',
                         password: '12345',
                         password_confirmation: '12345')
      origin_data = 'Denver,CO'
      destination_data = 'Telluride,CO'

      trip = RoadTripFacade.get_trip(origin_data, destination_data, user)

      expect(trip).to be_a(RoadTrip)
      expect(trip.destination).to eq(destination_data)
      expect(trip.origin).to eq(origin_data)
      expect(trip.travel_time).to be_an(String)
      expect(trip.weather_at_eta).to be_a(Hash)
      expect(trip.weather_at_eta.keys.count).to eq(2)
    end
  end
end
