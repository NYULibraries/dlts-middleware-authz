require 'rails_helper'

RSpec.describe 'Api::AuthIpAddresses', type: :request do
  context 'when api token is correct' do
    let(:api_key) { FactoryGirl.create(:api_key) }

    describe 'GET /api/auth_ip_addresses' do
      it 'returns a list of auth_ip_addresses' do
        FactoryGirl.create_list(:auth_ip_address, 10, [:ipv4, :ipv6].sample)
        get '/api/auth_ip_addresses', params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json.length).to eq(10)
      end
    end

    describe 'GET /api/auth_ip_addresses/:id' do
      let(:auth_ipv4_address) { FactoryGirl.create(:auth_ip_address, :ipv4) }
      let(:auth_ipv6_address) { FactoryGirl.create(:auth_ip_address, :ipv6) }

      it 'returns a single auth_ip_address' do
        get "/api/auth_ip_addresses/#{auth_ipv4_address.id}", params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json['ip_address']).to eq(auth_ipv4_address.ipv4_address)
      end

      it 'returns a single auth_ip_address' do
        get "/api/auth_ip_addresses/#{auth_ipv6_address.id}", params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json['ip_address']).to eq(auth_ipv6_address.ipv6_address)
      end
    end

    describe 'POST /api/auth_ip_addresses' do
      it 'creates an ipv4 auth_ip_address' do
        auth_ip_address_name = Faker::StarWars.droid
        auth_ip_address_ipv4_address = Faker::Internet.ip_v4_address
        auth_ip_addresses_params = {
            name: auth_ip_address_name,
            ipv4_address: auth_ip_address_ipv4_address,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        post '/api/auth_ip_addresses', params: auth_ip_addresses_params, headers: request_headers

        expect(response).to have_http_status :created
        expect(AuthIpAddress.first.name).to eq auth_ip_address_name
        expect(AuthIpAddress.first.ipv4_address).to eq auth_ip_address_ipv4_address
      end

      it 'creates an ipv6 auth_ip_address' do
        auth_ip_address_name = Faker::StarWars.droid
        auth_ip_address_ipv6_address = Faker::Internet.ip_v6_address
        auth_ip_addresses_params = {
            name: auth_ip_address_name,
            ipv6_address: auth_ip_address_ipv6_address,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        post '/api/auth_ip_addresses', params: auth_ip_addresses_params, headers: request_headers

        expect(response).to have_http_status :created
        expect(AuthIpAddress.first.name).to eq auth_ip_address_name
        expect(AuthIpAddress.first.ipv6_address).to eq auth_ip_address_ipv6_address
      end
    end

    describe 'PUT /api/auth_ip_addresses' do
      let(:auth_ip_address) { FactoryGirl.create(:auth_ip_address, [:ipv4, :ipv6].sample) }

      it 'updates an auth_ip_address' do
        new_auth_ip_address_name = Faker::StarWars.droid
        auth_ip_addresses_params = {
            name: new_auth_ip_address_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        put "/api/auth_ip_addresses/#{auth_ip_address.id}", params: auth_ip_addresses_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(AuthIpAddress.first.name).to eq new_auth_ip_address_name
      end
    end

    describe 'PATCH /api/auth_ip_addresses' do
      let(:auth_ip_address) { FactoryGirl.create(:auth_ip_address, [:ipv4, :ipv6].sample) }

      it 'updates an auth_ip_address' do
        new_auth_ip_address_name = Faker::StarWars.droid
        auth_ip_addresses_params = {
            name: new_auth_ip_address_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        patch "/api/auth_ip_addresses/#{auth_ip_address.id}", params: auth_ip_addresses_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(AuthIpAddress.first.name).to eq new_auth_ip_address_name
      end
    end

    describe 'DELETE /api/auth_ip_addresses' do
      let(:auth_ip_address) { FactoryGirl.create(:auth_ip_address, [:ipv4, :ipv6].sample) }
      it 'deletes an auth_ip_address' do
        delete "/api/auth_ip_addresses/#{auth_ip_address.id}", params: {api_key: api_key.full_api_key}

        expect(response).to have_http_status :no_content
        expect(AuthIpAddress.count).to eq 0
      end
    end
  end
end
