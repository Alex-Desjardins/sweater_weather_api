require 'rails_helper'

RSpec.describe RoadTripFacade do
  it '::get_trip' do
    VCR.use_cassette('Telluride trip') do
      user = User.create(email: 'me@user.com',
                         password: '12345',
                         password_confirmation: '12345')
      origin = 'Denver,CO'
      dest = 'Telluride,CO'

      trip = RoadTripFacade.get_trip(origin, dest, user)

      expect(trip).to be_a(RoadTrip)
    end
  end
end
