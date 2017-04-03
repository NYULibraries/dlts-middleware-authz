require 'rails_helper'
require 'cgi'

RSpec.describe 'Items', type: :request do
  describe 'get /items' do
    before do
      get "/item/#{item.handle}"
      # follow 3 redirects to auth and come back
      3.times { follow_redirect! }
    end

    context 'It redirects to the end_service URI with the proper params' do
      let (:item) { FactoryGirl.create(:item) }
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

    context 'It interpolates strings if it can' do
      let (:end_service) { FactoryGirl.create(:end_service, uri: 'https://example.com/:item_uri_fragment/:session_token/:item_handle') }
      let (:item) { FactoryGirl.create(:item, end_service: end_service) }

      it do
        expect(response).to redirect_to("https://example.com/#{item.uri_fragment.gsub(' ', '+')}/#{session[:session]['token']}/#{item.handle}")
      end
    end
  end
end
