require 'rails_helper'

RSpec.describe 'User login POST request; happy path' do

  it 'User data for login; success' do
    user = User.create(email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345')

    login_params = {email: user.email, password: user.password}

    header = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/sessions', headers: header, params: JSON.generate(login_params)

    login_json = JSON.parse(response.body, symbolize_names: true)
  
    expect(login_json[:data][:type]).to eq("user")
    expect(login_json[:data][:id]).to eq(user.id.to_s)
    expect(login_json[:data][:attributes].keys.count).to eq(2)
    expect(login_json[:data][:attributes]).to have_key(:email)
    expect(login_json[:data][:attributes][:email]).to eq(user.email)
    expect(login_json[:data][:attributes]).to have_key(:api_key)
    expect(login_json[:data][:attributes][:api_key]).to eq(user.api_key)
  end
end
