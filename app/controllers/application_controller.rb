class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authentication_callback
    auth = request.env['omniauth.auth']
    session[:auth] = auth
    redirect_to '/' # TODO: make this redirect back to the asset, or a denied page if needed?
  end

  def authenticate!
    redirect_to '/auth/nyulibraries' unless session[:auth] && (session[:auth]['credentials']['expires'] == false || session[:auth]['credentials']['expires_at'] > Time.now.to_i)
  end
end
