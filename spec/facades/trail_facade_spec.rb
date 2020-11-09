require 'rails_helper'

RSpec.describe TrailFacade do
  it '::get_trail' do
    VCR.use_cassette('Telluride facade') do
      trail = TrailFacade.get_trail('Telluride,CO')
      expect(trail).to be_a(Trail)
    end
  end
end
