require 'rails_helper'

describe DarkSkyClient do
  context 'hitting the dark sky api' do
    describe '#fetch_weather_json' do
      let(:token) { 'token' }
      let(:latitude) { 'foo' }
      let(:longitude) { 'bar' }
      let(:epochtime) { '42' }
      let(:url) { "https://api.darksky.net/forecast/#{token}/#{latitude},#{longitude},#{epochtime}?exclude=currently,minutely,daily,flags,alerts" }
      let(:json_body) { { candy: 'tasty' }.to_json }

      before do
        stub_request(:get, /api.darksky.net/).to_return(status: 200, body: json_body, headers: {})
        allow(subject).to receive(:token).and_return(token)
        allow(subject).to receive(:epochtime).and_return(epochtime)
      end

      subject { DarkSkyClient.new(latitude: latitude, longitude: longitude, datetime: 'last thursday') }
      it 'sends the assembled URL to curb' do
        expect(Curl::Easy).to receive(:new).with(url).and_call_original
        subject.fetch_weather_json
      end

      it 'parses the api result' do
        expect(JSON).to receive(:parse).with(json_body)
        subject.fetch_weather_json
      end
    end
  end
end
