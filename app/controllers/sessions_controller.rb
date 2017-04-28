class SessionsController < ApplicationController
  def authentication_callback
    my_session = Session.create!(data: request.env['omniauth.auth'])
    session[:session] = my_session
    redirect_uri = session[:redirect_to] || '/'
    session.delete :redirect_uri
    redirect_to redirect_uri
  end

  def self.create_ip_session(session)
    # noinspection RubyStringKeysInHashInspection
    session[:session] = {'token' => 'IP_BASED_AUTH'}
  end
end
