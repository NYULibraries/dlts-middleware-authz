require 'rails_helper'

RSpec.describe "Api::Items", type: :request do
  context 'when api token is correct' do
    let(:api_key) { FactoryGirl.create(:api_key) }
    describe 'GET /api/items' do
      it 'returns a list of items' do
        FactoryGirl.create_list(:item, 10)
        get '/api/items', params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json.length).to eq(10)
      end
    end

    describe 'GET /api/items/:id' do
      let(:item) { FactoryGirl.create(:item) }
      it 'returns a single item' do
        get "/api/items/#{item.id}", params: {api_key: api_key.full_api_key}
        expect(response).to have_http_status :success
        json = JSON.parse(response.body)
        expect(json['token']).to eq(item.token)
      end
    end

    describe 'POST /api/items' do
      it 'creates an item' do
        item_handle = Faker::Internet.unique.password(17, 17)
        item_token = Faker::Internet.unique.password(35, 35)
        item_end_service_id = FactoryGirl.create(:end_service).id
        items_params = {
            handle: item_handle,
            token: item_token,
            end_service_id: item_end_service_id,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        post '/api/items', params: items_params, headers: request_headers

        expect(response).to have_http_status :created
        expect(Item.first.handle).to eq item_handle
        expect(Item.first.token).to eq item_token
        expect(Item.first.end_service_id).to eq item_end_service_id
      end
    end

    describe 'PUT /api/items' do
      let(:item) { FactoryGirl.create(:item) }
      it 'updates an item' do
        new_item_handle = Faker::Internet.unique.password(17, 17)
        items_params = {
            handle: new_item_handle,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        put "/api/items/#{item.id}", params: items_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(Item.first.handle).to eq new_item_handle
      end
    end

    describe 'PATCH /api/items' do
      let(:item) { FactoryGirl.create(:item) }
      it 'updates an item' do
        new_item_handle = Faker::Internet.unique.password(17, 17)
        items_params = {
            handle: new_item_handle,
            api_key: api_key.full_api_key
        }.to_json

        request_headers = {
            Accept: 'application/json',
            :'Content-Type' => 'application/json'
        }

        put "/api/items/#{item.id}", params: items_params, headers: request_headers

        expect(response).to have_http_status :ok
        expect(Item.first.handle).to eq new_item_handle
      end
    end

    describe 'DELETE /api/items' do
      let(:item) { FactoryGirl.create(:item) }
      it 'deletes an item' do
        delete "/api/items/#{item.id}", params: {api_key: api_key.full_api_key}

        expect(response).to have_http_status :no_content
        expect(Item.count).to eq 0
      end
    end
  end
end
