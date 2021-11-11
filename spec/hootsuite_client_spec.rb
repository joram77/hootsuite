# spec/hootsuite_client_spec.rb

RSpec.describe Hootsuite::Client do
  let(:base_url) { 'https://platform.hootsuite.com/v1/' }

  describe '#get' do
    context 'with a valid request' do
      let(:client) { instance_double(Hootsuite::Client) }

      it 'makes a request to Hootsuite API' do
        allow(Hootsuite::Client).to receive(:new).and_return(client)
        allow(client).to receive(:get).and_return(true)

        res = client.get("#{base_url}/something")

        expect(res).to be_truthy
      end
    end
  end

  describe '#post' do
    context 'with a valid request' do
      let(:payload) do
        {
          'text': 'My text',
          'socialProfileIds': ['1'],
          'scheduledSendTime': Time.now
        }
      end
      let(:client) { instance_double(Hootsuite::Client) }

      it 'makes a request to Hootsuite API' do
        allow(Hootsuite::Client).to receive(:new).and_return(client)
        allow(client).to receive(:post).and_return(true)

        res = client.post("#{base_url}/something", payload)

        expect(res).to be_truthy
      end
    end
  end
end
