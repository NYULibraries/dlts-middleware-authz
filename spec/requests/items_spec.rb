require 'rails_helper'
require 'cgi'

RSpec.describe 'Items', type: :request do
  describe 'get /items' do

    context 'Item that has an ip_address' do
      let (:item) { FactoryGirl.create(:item, :auth_ip_address) }
      let (:end_service) { item.end_service }

      context 'when ip is authorized' do
        before do
          # Set Request IP address to be a valid IP from the item
          allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(item.auth_ip_addresses.first.ipv4_address)
          allow_any_instance_of(ActionDispatch::Request).to receive(:ip).and_return(item.auth_ip_addresses.first.ipv4_address)
          get "/item/#{item.handle}"
        end

        it 'redirects to the end_service' do
          uri = URI(end_service.uri)
          uri.query = {
              item_handle: item.handle,
              session_token: session[:session]['token'],
              item_uri_fragment: item.uri_fragment
          }.to_query
          expect(response).to redirect_to(uri.to_s)
        end
      end

      context 'when ip is not authorized' do
        before do
          get "/item/#{item.handle}"
        end

        it do
          expect(response).to have_http_status :unauthorized
        end
      end
    end

    context 'Item has an auth_service' do
      let (:end_service) { FactoryGirl.create(:end_service, uri: 'https://example.com/:item_uri_fragment/:session_token/:item_handle') }
      let (:item) { FactoryGirl.create(:item, :auth_service, end_service: end_service) }
      before do
        get "/item/#{item.handle}"
        # follow 3 redirects to auth and come back
        3.times { follow_redirect! }
      end

      context 'Item redirects to the end_service URI with the proper params' do
        let (:item) { FactoryGirl.create(:item, :auth_service) }
        let (:end_service) { item.end_service }

        it { expect(response).to have_http_status(:redirect) }
        it do
          uri = URI(end_service.uri)
          uri.query = {
              item_handle: item.handle,
              session_token: session[:session]['token'],
              item_uri_fragment: item.uri_fragment
          }.to_query
          expect(response).to redirect_to(uri.to_s)
        end
      end

      context 'Item interpolates strings if it can' do
        it do
          expect(response).to redirect_to("https://example.com/#{item.uri_fragment.gsub(' ', '+')}/#{session[:session]['token']}/#{item.handle}")
        end
      end
    end
  end
end
