class Api::ApiController < ApplicationController
  before_action :authenticate!

  private
  def authenticate!
    unless params.has_key?(:api_key) && params[:api_key].length == 48
      head :unauthorized, status: 401
      return false
    end

    api_key_public = params[:api_key][0..23]
    api_key_private = params[:api_key][24..47]

    api_key = ApiKey.where(api_key_public: api_key_public).first
    render json: {error: 'API provided does not match any API keys on record.'} unless api_key.api_key_private == api_key_private
  end
end
