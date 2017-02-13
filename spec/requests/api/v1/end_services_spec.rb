require 'rails_helper'

RSpec.describe "Api::V1::EndServices", type: :request do
  context 'when api token is correct' do
    let(:api_key) { FactoryGirl.create(:api_key) }
    describe 'GET /api/v1/end_services' do
      it 'returns a list of end_services' do
        FactoryGirl.create_list(:end_service, 10)
        get '/api/v1/end_services', params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json.length).to eq(10)
      end
    end

    describe 'GET /api/v1/end_services/:id' do
      let(:end_service) { FactoryGirl.create(:end_service) }
      it 'returns a single end_service' do
        get "/api/v1/end_services/#{end_service.id}", params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json['name']).to eq(end_service.name)
      end
    end

    describe 'POST /api/v1/end_services' do
      it 'creates an end_service' do
        end_service_name = Faker::App.unique.name
        end_services_params = {
            name: end_service_name,
            uri: Faker::Internet.url,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        post '/api/v1/end_services', params: end_services_params, headers: request_headers

        expect(response).to have_http_status :created
        expect(EndService.first.name).to eq end_service_name
      end
    end

    describe 'PUT /api/v1/end_services' do
      let(:end_service) { FactoryGirl.create(:end_service) }
      it 'updates an end_service' do
        new_end_service_name = Faker::App.unique.name
        end_services_params = {
            name: new_end_service_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        put "/api/v1/end_services/#{end_service.id}", params: end_services_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(EndService.first.name).to eq new_end_service_name
      end
    end

    describe 'PATCH /api/v1/end_services' do
      let(:end_service) { FactoryGirl.create(:end_service) }
      it 'updates an end_service' do
        new_end_service_name = Faker::App.unique.name
        end_services_params = {
            name: new_end_service_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        patch "/api/v1/end_services/#{end_service.id}", params: end_services_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(EndService.first.name).to eq new_end_service_name
      end
    end

    describe 'DELETE /api/v1/end_services' do
      let(:end_service) { FactoryGirl.create(:end_service) }
      it 'deletes an end_service' do
        delete "/api/v1/end_services/#{end_service.id}", params: {api_key: api_key.full_api_key}

        expect(response).to have_http_status :no_content
        expect(EndService.count).to eq 0
      end
    end
  end
end
