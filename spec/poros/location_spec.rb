require 'rails_helper'

RSpec.describe Location do
  it 'has attributes' do
    data = {:adminArea5=>"Denver",
        :adminArea3=>"CO",
        :adminArea1=>"US",
        :latLng=>{:lat=>39.738453, :lng=>-104.984853}}

    location = Location.new(data)

    expect(location).to be_a(Location)
    expect(location.coordinates).to be_a(Hash)
    expect(location.coordinates).to eq(data[:latLng])
    expect(location.city).to eq(data[:adminArea5])
    expect(location.state).to eq(data[:adminArea3])
    expect(location.country).to eq(data[:adminArea1])
  end
end
