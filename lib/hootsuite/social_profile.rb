# frozen_string_literal: true

module Hootsuite
  class SocialProfile
    ENDPOINT = 'v1/socialProfiles'

    def initialize
      @client = Client.new
    end

    def social_profile_ids
      r = @client.get(ENDPOINT)

      if r.status.success?
        return [] if r.body.to_s.empty?

        extract_ids(JSON.parse(r.body.to_s))
      else
        puts r.body.to_s
      end
    end

    private

    def extract_ids(response)
      response['data'].map do |profile|
        Profile.new(profile).id
      end
    end

    class Profile
      def initialize(profile)
        @profile = profile
      end

      def id
        @profile['id']
      end

      def type
        @profile['type']
      end
    end
  end
end
