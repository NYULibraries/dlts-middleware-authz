require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do
  controller do
    def index
      render plain: 'Restricted Api Content'
    end
  end

  describe 'authenticate!' do
    context 'valid API key' do
      it do
        api_key = FactoryGirl.create(:api_key).full_api_key
        get :index, params: {api_key: api_key}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'no API key' do
      it do
        get :index
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'invalid API key' do
      it do
        get :index, params: { api_key: 'invalid_api_key' }
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
