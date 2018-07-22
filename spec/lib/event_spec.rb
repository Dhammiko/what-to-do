require 'rails_helper'

describe Event do
  let(:name) { 'an awesome event' }
  let(:date) { '2018-07-07T11:00:00' }
  let(:venue) { double }
  let(:forecast) { FactoryBot.create(:forecast) }
  let(:event_json) {JSON.parse({
                    name: {text: "#{name}"},
                    start: {local: "#{date}"}
                  }.to_json)}
  describe "#to_s" do
    before do
      allow(subject).to receive(:dsclient).and_return(double)
      allow(subject).to receive(:forecast).and_return(forecast)
      allow(subject).to receive(:venue).and_return(venue)
    end

    subject { Event.new(event_json) }
    it 'includes the event title' do
      expect(subject.to_s).to include(name)
    end

    it 'includes the date' do
      expect(subject.to_s).to include("2018-07-07 11:00 AM")
    end

    it 'calls to_s on venue' do
      expect(venue).to receive(:to_s)
      subject.to_s
    end

    it 'calls to_s on forecast' do
      expect(forecast).to receive(:to_s)
      subject.to_s
    end

    it 'returns an empty array if the event is rainy' do
      allow(subject).to receive(:forecast) { FactoryBot.create(:forecast, rain?: true) }
      expect(subject.to_s).to eq([])
    end
  end
end
