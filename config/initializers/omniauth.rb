Rails.application.config.middleware.use OmniAuth::Builder do |config|
  provider :nyulibraries, ENV['OAUTH_APPLICATION_ID'], ENV['OAUTH_APPLICATION_SECRET'],
           client_options: {
               site: ENV['OAUTH_SITE'],
               authorize_path: '/oauth/authorize'
           }

  config.on_failure do
    Rack::Response.new(['403 Unauthorized'], 403).finish
  end
end