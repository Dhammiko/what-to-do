require 'rails_helper'

describe Event do
  let(:name) { 'an awesome event' }
  let(:date) { '2018-07-07T11:00:00' }
  let(:venue_name) { 'the darrell ampitheater' }
  let(:venue_address) { '123 cherry lane' }
  let(:weather_forecast) { 'so bright it hurts' }
  let(:venue) { double('A Venue', name: venue_name, address: venue_address) }
  let(:forecast) { FactoryBot.create(:forecast, forecast: weather_forecast) }
  let(:event_json) {JSON.parse({
                    name: {text: "#{name}"},
                    start: {local: "#{date}"}
                  }.to_json)}


  before do
    allow_any_instance_of(Event).to receive(:dsclient).and_return(double)
    allow_any_instance_of(Event).to receive(:forecast).and_return(forecast)
    allow_any_instance_of(Event).to receive(:venue).and_return(venue)
  end

  subject { Event.new(event_json) }

  describe '#name' do
    it 'includes the event title' do
      expect(subject.name).to eq(name)
    end
  end

  describe '#venue_name' do
    it 'delegates to the venue object' do
      expect(subject.venue_name).to eq(venue_name)
    end
  end

  describe '#venue_address' do
    it 'delegates to the venue object' do
      expect(subject.venue_address).to eq(venue_address)
    end
  end

  describe '#weather_forecast' do
    it 'delegates to the forecast object' do
      expect(subject.weather_forecast).to eq(weather_forecast)
    end
  end

  describe '#weather_forecast' do
    it 'delegates to the forecast object' do
      expect(subject.rainy_event?).to be_falsey
    end
  end

  describe '#date' do
    it 'returns a nice formatted date' do
      expect(subject.date).to eq("2018-07-07 11:00 AM")
    end
  end
end