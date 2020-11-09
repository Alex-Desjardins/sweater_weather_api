require 'rails_helper'

RSpec.describe ImageFacade do
  it '::get_image' do
    VCR.use_cassette('Miami image') do
      image = ImageFacade.get_image('Miami')

      expect(image).to be_a(Image)
      expect(image.credit).to be_a(Hash)
      expect(image.location).to be_a(String)
      expect(image.url).to be_a(String)
    end
  end
end
