# frozen_string_literal: true

require "dotenv/load"
require "byebug"
require "http"

require_relative "hootsuite/version"
require_relative "hootsuite/social_profile"
require_relative "hootsuite/schedule"

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
  end
end
