# spec/hootsuite/schedule_spec.rb

RSpec.describe Hootsuite::Schedule do
  let(:base_url) { 'https://platform.hootsuite.com/v1' }
  let(:access_token) { 'TOKEN' }

  describe '#send' do
    context 'when message is scheduled' do
      let(:message) { 'Hola mundo' }
      let(:social_profile_ids) { ['1'] }
      let(:schedule_time) { Time.now }

      let(:client) do
        described_class.new(
          message: message,
          social_profile_ids: social_profile_ids,
          schedule_time: schedule_time
        )
      end

      let(:successful_response) do
        JSON.dump(
          {
            "data": [
              {
                "id": "1231244",
                "state": "SCHEDULED"
              }
            ]
          }
        )
      end

      it 'goes to hootsuite schedule', :aggregate_failures do
        stub_request(:post, "#{base_url}/messages")
          .with(
            headers: {
              'Authorization' => "Bearer #{access_token}",
              'Connection' => 'close',
              'Host' => 'platform.hootsuite.com',
              'User-Agent' => 'http.rb/4.4.1'
            }
          )
          .to_return(
            status: 200,
            body: successful_response
          )

        res = client.send

        expect(res).to eq('yay')
      end
    end
  end
end
