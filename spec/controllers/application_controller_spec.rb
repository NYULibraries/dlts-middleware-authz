require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :authenticate!
    def index
      render plain: 'Restricted OAuth Content'
    end
  end

  describe 'authenticate!' do
    context 'It redirects if not authenticated' do
      before { get :index }
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to('/auth/nyulibraries') }
    end
  end
end
