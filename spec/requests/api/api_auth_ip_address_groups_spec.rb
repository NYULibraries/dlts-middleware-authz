require 'rails_helper'

RSpec.describe "Api::AuthIpAddressGroups", type: :request do
  context 'when api token is correct' do
    let(:api_key) { FactoryGirl.create(:api_key) }
    describe 'GET /api/auth_ip_address_groups' do
      it 'returns a list of auth_ip_address_groups' do
        FactoryGirl.create_list(:auth_ip_address_group, 10)
        get '/api/auth_ip_address_groups', params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json.length).to eq(10)
      end
    end

    describe 'GET /api/auth_ip_address_groups/:id' do
      let(:auth_ip_address_group) { FactoryGirl.create(:auth_ip_address_group) }
      it 'returns a single auth_ip_address_group' do
        get "/api/auth_ip_address_groups/#{auth_ip_address_group.id}", params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json['name']).to eq(auth_ip_address_group.name)
      end
    end

    describe 'POST /api/auth_ip_address_groups' do
      it 'creates an auth_ip_address_group' do
        auth_ip_address_group_name = Faker::App.unique.name
        auth_ip_address_groups_params = {
            name: auth_ip_address_group_name,
            uri: Faker::Internet.url,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        post '/api/auth_ip_address_groups', params: auth_ip_address_groups_params, headers: request_headers

        expect(response).to have_http_status :created
        expect(AuthIpAddressGroup.first.name).to eq auth_ip_address_group_name
      end
    end

    describe 'PUT /api/auth_ip_address_groups' do
      let(:auth_ip_address_group) { FactoryGirl.create(:auth_ip_address_group) }
      it 'updates an auth_ip_address_group' do
        new_auth_ip_address_group_name = Faker::App.unique.name
        auth_ip_address_groups_params = {
            name: new_auth_ip_address_group_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        put "/api/auth_ip_address_groups/#{auth_ip_address_group.id}", params: auth_ip_address_groups_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(AuthIpAddressGroup.first.name).to eq new_auth_ip_address_group_name
      end
    end

    describe 'PATCH /api/auth_ip_address_groups' do
      let(:auth_ip_address_group) { FactoryGirl.create(:auth_ip_address_group) }
      it 'updates an auth_ip_address_group' do
        new_auth_ip_address_group_name = Faker::App.unique.name
        auth_ip_address_groups_params = {
            name: new_auth_ip_address_group_name,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        patch "/api/auth_ip_address_groups/#{auth_ip_address_group.id}", params: auth_ip_address_groups_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(AuthIpAddressGroup.first.name).to eq new_auth_ip_address_group_name
      end
    end

    describe 'DELETE /api/auth_ip_address_groups' do
      let(:auth_ip_address_group) { FactoryGirl.create(:auth_ip_address_group) }
      it 'deletes an auth_ip_address_group' do
        delete "/api/auth_ip_address_groups/#{auth_ip_address_group.id}", params: {api_key: api_key.full_api_key}

        expect(response).to have_http_status :no_content
        expect(AuthIpAddressGroup.count).to eq 0
      end
    end
  end
end
