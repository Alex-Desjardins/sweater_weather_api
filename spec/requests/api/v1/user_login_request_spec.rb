require 'rails_helper'

RSpec.describe 'User login POST request' do
  it 'User login; success' do
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

  it 'User login fail; empty email' do
    user = User.create(email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345')

    login_params = {email: '', password: user.password}

    header = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/sessions', headers: header, params: JSON.generate(login_params)

    request_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')
    expect(request_json[:error]).to eq("Please Fill In All Fields")
  end

  it 'User login fail; empty password' do
    user = User.create(email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345')

    login_params = {email: user.email, password: ''}

    header = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/sessions', headers: header, params: JSON.generate(login_params)

    request_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')
    expect(request_json[:error]).to eq("Please Fill In All Fields")
  end

  it 'User login fail; incorrect email' do
    user = User.create(email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345')

    login_params = {email: 'you@user.com', password: user.password}

    header = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/sessions', headers: header, params: JSON.generate(login_params)

    request_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')
    expect(request_json[:error]).to eq("Incorrect Email or Password")
  end

  it 'User login fail; incorrect password' do
    user = User.create(email: 'me@user.com',
                   password: '12345',
                   password_confirmation: '12345')

    login_params = {email: user.email, password: '54321'}

    header = {'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/sessions', headers: header, params: JSON.generate(login_params)

    request_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')
    expect(request_json[:error]).to eq("Incorrect Email or Password")
  end
end
