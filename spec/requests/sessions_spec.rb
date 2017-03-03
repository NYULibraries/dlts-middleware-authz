require 'rails_helper'

RSpec.describe 'OAuth', type: :request do
  context 'OAuth Success' do
    before { get '/auth/nyulibraries' }
    it { expect(response).to have_http_status(:redirect) }
    it { expect(response).to redirect_to('/auth/nyulibraries/callback') }
  end

  context 'Oauth Error' do
    before do
      OmniAuth.config.mock_auth[:nyulibraries] = :invalid_credentials
      get '/auth/nyulibraries'
      follow_redirect!
    end
    it { expect(response).to have_http_status(:forbidden) }
  end
end
