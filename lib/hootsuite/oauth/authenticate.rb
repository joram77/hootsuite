# frozen_string_literal: true
# lib/hootsuite/oauth/authenticate.rb

require "dotenv/load"

module Hootsuite
  module Oauth
    class Authenticate
      BASE_URL = 'https://platform.hootsuite.com'
      AUTH_ENDPOINT = 'oauth2/auth'
      TOKEN_ENDPOINT = 'oauth2/token'
      HEADERS = { "Content-Type" => "application/x-www-form-urlencoded" }
      REDIRECT_URI = ENV['REDIRECT_URI']
      CLIENT_ID = ENV['CLIENT_ID']

      def self.auth_url
        "#{BASE_URL}/#{AUTH_ENDPOINT}?response_type=code&client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}"
      end

      def initialize(code)
        @client = Client.new
        @code = code
      end

      def request
        r = @client.authenticate(TOKEN_ENDPOINT, headers: HEADERS, params: payload)

        if r.status.success?
          parsed = JSON.parse(r.body.to_s)

          {
            access_token: parsed['access_token'],
            refresh_token: parsed['refresh_token']
          }
        else
          puts r.body.to_s
        end
      end

      private

      def payload
        {
          code: @code,
          grant_type: 'authorization_code',
          redirect_uri: REDIRECT_URI
        }
      end
    end
  end
end
