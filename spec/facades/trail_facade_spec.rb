require 'rails_helper'

RSpec.describe TrailFacade do
  it '::get_trail' do
    VCR.use_cassette('Telluride trails') do
      trails = TrailFacade.get_trail('Telluride,CO')
      expect(trails).to be_a(trail)
    end
  end
end
