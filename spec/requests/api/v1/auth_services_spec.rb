require 'rails_helper'

RSpec.describe 'Api::V1::AuthServices', type: :request do
  context 'when api token is correct' do
    let(:api_key) { FactoryGirl.create(:api_key) }
    describe 'GET /api/v1/auth_services' do
      it 'returns a list of auth_services' do
        FactoryGirl.create_list(:auth_service, 10)
        get '/api/v1/auth_services', params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json.length).to eq(10)
      end
    end

    describe 'GET /api/v1/auth_services/:id' do
      let(:auth_service) { FactoryGirl.create(:auth_service) }
      it 'returns a single auth_service' do
        get "/api/v1/auth_services/#{auth_service.id}", params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json['name']).to eq(auth_service.name)
      end
    end

    describe 'POST /api/v1/auth_services' do
      it 'creates an auth_service' do
        auth_service_name = Faker::App.unique.name
        auth_services_params = {
            name: auth_service_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        post '/api/v1/auth_services', params: auth_services_params, headers: request_headers

        expect(response).to have_http_status :created
        expect(AuthService.first.name).to eq auth_service_name
      end
    end

    describe 'PUT /api/v1/auth_services' do
      let(:auth_service) { FactoryGirl.create(:auth_service) }
      it 'updates an auth_service' do
        new_auth_service_name = Faker::App.unique.name
        auth_services_params = {
            name: new_auth_service_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        put "/api/v1/auth_services/#{auth_service.id}", params: auth_services_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(AuthService.first.name).to eq new_auth_service_name
      end
    end

    describe 'PATCH /api/v1/auth_services' do
      let(:auth_service) { FactoryGirl.create(:auth_service) }
      it 'updates an auth_service' do
        new_auth_service_name = Faker::App.unique.name
        auth_services_params = {
            name: new_auth_service_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        patch "/api/v1/auth_services/#{auth_service.id}", params: auth_services_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(AuthService.first.name).to eq new_auth_service_name
      end
    end

    describe 'DELETE /api/v1/auth_services' do
      let(:auth_service) { FactoryGirl.create(:auth_service) }
      it 'deletes an auth_service' do
        delete "/api/v1/auth_services/#{auth_service.id}", params: {api_key: api_key.full_api_key}

        expect(response).to have_http_status :no_content
        expect(AuthService.count).to eq 0
      end
    end
  end
end
