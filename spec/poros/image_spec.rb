require 'rails_helper'

RSpec.describe Image do
  it 'has attributes' do
    image_data = {:url=>"www.unionstation.org",
                  :photographer=>"Scrappy",
                  :photographer_url=>"www.photographer.com"}

    location = "Denver"

    image = Image.new(location, image_data)

    expect(image).to be_a(Image)
    expect(image.id).to eq(nil)
    expect(image.location).to eq(location)
    expect(image.url).to eq(image_data[:url])
    expect(image.credit[:source]).to eq('pexels.com')
    expect(image.credit[:photographer]).to eq(image_data[:photographer])
    expect(image.credit[:photographer_url]).to eq(image_data[:photographer_url])
  end
end
