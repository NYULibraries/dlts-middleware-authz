Rails.application.config.middleware.use OmniAuth::Builder do
provider :nyulibraries, ENV['OAUTH_APPLICATION_ID'], ENV['OAUTH_APPLICATION_SECRET'],
         client_options: {
             site: ENV['OAUTH_SITE'],
             authorize_path: '/oauth/authorize'
         }
end