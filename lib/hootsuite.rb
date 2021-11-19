# frozen_string_literal: true

require "dotenv"
require "byebug"
require "http"

require_relative "hootsuite/version"
require_relative "hootsuite/social_profile"
require_relative "hootsuite/schedule"
require_relative "hootsuite/oauth/authenticate"
require_relative "hootsuite/oauth/refresh_token"

Dotenv.load('.env', '.env.test')

module Hootsuite
  class Error < StandardError; end

  class Client
    BASE_URL = 'https://platform.hootsuite.com'
    ACCESS_TOKEN = ENV['HOOTSUITE_ACCESS_TOKEN']

    def get(endpoint)
      HTTP.auth("Bearer #{ACCESS_TOKEN}")
          .get("#{BASE_URL}/#{endpoint}")
    end

    def post(endpoint, params)
      HTTP.auth("Bearer #{ACCESS_TOKEN}")
          .post("#{BASE_URL}/#{endpoint}", json: params)
    end

    def authenticate(endpoint, headers:, params:)
      HTTP.basic_auth(user: ENV['CLIENT_ID'], pass: ENV['SECRET_ID'])
          .headers(headers)
          .post("#{BASE_URL}/#{endpoint}", form: params)
    end
  end
end
