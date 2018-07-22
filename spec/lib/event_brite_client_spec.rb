require 'spec_helper'

describe EventBriteClient do
  let(:host) { 'eventbrite' }
  let(:token) { 'foo' }
  let(:json_body) { {events: []}.to_json }
  before do
    allow(subject).to receive(:host).and_return(host)
    allow(subject).to receive(:token).and_return(token)
    stub_request(:get, %r{darksky.net/*}).to_return(status: 200, body: json_body, headers: {})
    stub_request(:get, %r{eventbriteevents/*}).to_return(status: 200, body: json_body, headers: {})
  end

  subject { EventBriteClient.new }
  context "fetching event data" do
    let(:zipcode) { 123 } 
    let(:events_url) { "#{host}events/search/?token=#{token}&location.address=#{zipcode}&start_date.range_start=#{events_start_date}&start_date.range_end=#{events_end_date}" }
    let(:date_format) {"%Y-%m-%dT%H:%M:%S"}
    let(:datetime) { DateTime.now}
    let(:events_start_date) { datetime.strftime(date_format) }
    let(:events_end_date) { (datetime + 7).strftime(date_format) }

    describe "#events_for" do
      it "assembles the events url" do
        expect(subject).to receive(:get_json).with(events_url).and_call_original
        subject.events_for(zipcode: zipcode, datetime: datetime)
      end
    end
  end

  context "fetching venue data" do
    let(:venue_id) { 123 }
    let(:venue_url) { "#{host}venues/#{venue_id}/?token=#{token}" }

    describe "#venue_for" do
      it "assembles the venue url" do
        expect(subject).to receive(:get_json).with(venue_url)
        subject.venue_for(venue_id)
      end
    end
  end
end
