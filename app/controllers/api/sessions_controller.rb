class Api::SessionsController < Api::ApiController
  def verify
    if Session.where(token: params[:session_token]).where('expires_at > ?', Time.now).exists?
      render json: {success: true}, status: :ok
      return
    end
    render json: {success: false}, status: :unauthorized
  end
end
