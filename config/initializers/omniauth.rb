Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, APP_CONFIG[:github_key], APP_CONFIG[:github_secret]
end