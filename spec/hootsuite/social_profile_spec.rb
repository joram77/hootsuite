# spec/hootsuite/social_profile_spec.rb

RSpec.describe Hootsuite::SocialProfile do
  let(:base_url) { 'https://platform.hootsuite.com/v1' }
  let(:access_token) { 'h6Y8yTOCwrvx_GVcTHXQDfk2EyXePLiFXz2gJohWaAw.0KdxEKAh5nKu7HISGFy4H2jvlHfvvwSpemvU1yCxTPg' }

  describe '#social_profile_ids' do
    context 'with social profile ids' do
      let(:client) { described_class.new }
      let(:twitter_id) { "134615263" }

      let(:successful_response) do
        JSON.dump(
          {
            data: [
              {
                "id": twitter_id,
                "type": "TWITTER",
              }
            ]
          }
        )
      end

      it 'returns the social profile ids', :aggregate_failures do
        stub_request(:get, "#{base_url}/socialProfiles")
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

        res = client.social_profile_ids

        expect(res).to be_a(Array)
        expect(res).not_to be_empty
        expect(res.first).to eq(twitter_id)
      end
    end
  end
end
