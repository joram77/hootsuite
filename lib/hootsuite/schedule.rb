# frozen_string_literal: true

module Hootsuite
  class Schedule
    ENDPOINT = 'v1/messages'

    def initialize(message:, social_profile_ids: [], schedule_time: nil)
      @client = Client.new
      @message = message
      @social_profile_ids = social_profile_ids
      @schedule_time = schedule_time
    end

    def send
      r = @client.post(ENDPOINT, payload)

      if r.status.success?
        puts "yay"
      else
        puts r.body.to_s
      end
    end

    private

    def payload
      {
        'text': @message,
        'socialProfileIds': @social_profile_ids,
        'scheduledSendTime': @schedule_time
      }
    end
  end
end
