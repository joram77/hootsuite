# frozen_string_literal: true
# lib/hootsuite/oauth/authenticate.rb

module Hootsuite
  module Oauth
    class Authenticate
      ENDPOINT = 'oauth2/token'
      HEADERS = { "Content-Type" => "application/x-www-form-urlencoded" }

      def initialize(code)
        @client = Client.new
        @code = code
      end

      def request
        r = @client.authenticate(ENDPOINT, headers: HEADERS, params: payload)

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
          redirect_uri: ENV['REDIRECT_URI']
        }
      end
    end
  end
end
