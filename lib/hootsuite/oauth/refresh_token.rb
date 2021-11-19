# frozen_string_literal: true
# lib/hootsuite/oauth/refresh_token.rb

module Hootsuite
  module Oauth
    class RefreshToken
      ENDPOINT = 'oauth2/token'
      HEADERS = { "Content-Type" => "application/x-www-form-urlencoded" }

      def initialize(refresh_token)
        @client = Client.new
        @refresh_token = refresh_token
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
          grant_type: 'refresh_token',
          refresh_token: @refresh_token
        }
      end
    end
  end
end
