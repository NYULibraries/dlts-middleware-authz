class ApplicationController < ActionController::Base
  include ActionController::Serialization

  def authenticate!
    my_session = false
    my_session = Session.find(session[:session]['id']) if session[:session]
    unless my_session && (my_session.expires_at > Time.now.utc)
      my_session.destroy if my_session
      session.delete :session
      session[:redirect_to] = request.fullpath
      redirect_to '/auth/nyulibraries'
    end
  end
  
  private
  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
