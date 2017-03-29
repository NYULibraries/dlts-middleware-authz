require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  context 'when api token is correct' do
    let(:api_key) { FactoryGirl.create(:api_key) }

    describe 'GET /api/sessions/verify' do
      context 'when session is valid' do
        let(:session) { FactoryGirl.create(:session) }
        before { get '/api/sessions/verify', params: {api_key: api_key.full_api_key, session_token: session.token} }
        it { expect(response).to have_http_status :success }
        it { expect(response.body).to eq({success: true}.to_json) }
      end

      context 'when session is expired' do
        let(:session) { FactoryGirl.create(:session) }
        before do
          session.expires_at = 5.minutes.ago
          session.save
          get '/api/sessions/verify', params: {api_key: api_key.full_api_key, session_token: session.token}
        end
        it { expect(response).to have_http_status :unauthorized }
        it { expect(response.body).to eq({success: false}.to_json) }
      end

      context 'when session does not exist' do
        before do
          get '/api/sessions/verify', params: {api_key: api_key.full_api_key, session_token: 'invalid token'}
        end
        it { expect(response).to have_http_status :unauthorized }
        it { expect(response.body).to eq({success: false}.to_json) }
      end

      context 'when session is not passed in' do
        before do
          get '/api/sessions/verify', params: {api_key: api_key.full_api_key}
        end
        it { expect(response).to have_http_status :unauthorized }
        it { expect(response.body).to eq({success: false}.to_json) }
      end
    end
  end
end
