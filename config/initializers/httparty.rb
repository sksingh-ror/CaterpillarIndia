# config/initializers/httparty.rb
HTTParty::Basement.default_options.update(
  timeout: 10, # Set timeout to 10 seconds
  open_timeout: 5, # Set open timeout to 5 seconds
  retry: 3, # Retry up to 3 times on failure
  headers: {
    'Content-Type' => 'application/json',
    'User-Agent' => 'CaterpillarIndia'
  }
)

# If you need to configure SSL options:
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
