require 'rails_helper'

RSpec.describe 'User Registration POST request' do
  it 'User registration; success' do
    user_params = {email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345'
                  }

    header = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/users', headers: header, params: JSON.generate(user_params)

    registration_json = JSON.parse(response.body, symbolize_names: true)

    user = User.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
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

  it 'User registration fail; password not matching' do
    user_params = {email: "me@user.com",
                password: "password",
                password_confirmation: "drowssap"}

    header = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', headers: header, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    expect(response.content_type).to eq('application/json')

    expect(User.all.count).to eq(0)

    request_json = JSON.parse(response.body, symbolize_names: true)
    expect(request_json[:error]).to eq("Password confirmation doesn't match Password")
  end

  it 'User registration fail; email currently in use' do
    existing_user = User.create!(email: "me@user.com",
                                 password: "password",
                                 password_confirmation: "password")

    user_params = {email: "me@user.com",
                password: "password",
                password_confirmation: "password"}

    header = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', headers: header, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    expect(response.content_type).to eq('application/json')

    expect(User.all.count).to eq(1)

    request_json = JSON.parse(response.body, symbolize_names: true)
    expect(request_json[:error]).to eq("Email has already been taken")
  end

  it 'User registration fail; missing field' do
    user_params = {email: "",
                password: "",
                password_confirmation: ""}

    header = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', headers: header, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    expect(response.content_type).to eq('application/json')

    expect(User.all.count).to eq(0)

    request_json = JSON.parse(response.body, symbolize_names: true)
    expect(request_json[:error]).to eq("Email can't be blank, Password can't be blank, and Password can't be blank")
  end
end
