require 'rails_helper'

RSpec.describe 'User Registration POST request; happy path' do

  it 'User data for registration; success' do
    user_params = {email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345'
                  }

    header = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/users', headers: header, params: JSON.generate(user_params)

    registration_json = JSON.parse(response.body, symbolize_names: true)

    user = User.last

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    expect(registration_json[:data][:type]).to eq('user')
    expect(registration_json[:data]).to have_key(:id)
    expect(registration_json[:data][:id]).to eq(user.id.to_s)
    expect(registration_json[:data]).to have_key(:attributes)
    expect(registration_json[:data][:attributes].keys.count).to eq(2)
    expect(registration_json[:data][:attributes]).to have_key(:email)
    expect(registration_json[:data][:attributes][:email]).to eq(user.email)
    expect(registration_json[:data][:attributes]).to have_key(:api_key)
    expect(registration_json[:data][:attributes][:api_key]).to eq(user.api_key)
    expect(registration_json[:data][:attributes]).to_not have_key(:password)
    expect(registration_json[:data][:attributes]).to_not have_key(:password_confirmation)
  end
end
