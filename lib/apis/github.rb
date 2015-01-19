module Apis
  module Github
    include HTTParty # https://github.com/jnunemaker/httparty

    AUTHORIZE_URL = 'https://github.com/login/oauth/authorize'
    ACCESS_TOKEN_URL = 'https://github.com/login/oauth/access_token'

    # See https://developer.github.com/v3/oauth/#web-application-flow
    # 1.step
    def generate_authorize_url(user, options={})
      options[:state] = user.generate_github_state! unless options.has_key?(:state)
      options[:client_id] = ENV['GITHUB_CLIENT_ID']
      options[:redirect_uri] = options[:redirect_uri] || github_callback_path()
      "#{AUTHORIZE_URL}?#{options.to_query}"
    end

    def self.get_access_token(user, code, redirect_url=nil)
      self.headers 'Accept' => 'application/json'
      params = {
        :code => code,
        :client_id => ENV['GITHUB_CLIENT_ID'],
        :client_secret => ENV['GITHUB_CLIENT_SECRET'],
        # :redirect_uri => redirect_url
      }
      self.post(ACCESS_TOKEN_URL, :query => params)['access_token']
    end
  end
end