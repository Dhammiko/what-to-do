require 'spec_helper'

describe Venue do
  let(:latitude) { "3" }
  let(:longitude) { "-7" }
  let(:venue_json) { {name: "a place",
                      latitude: latitude,
                      longitude: longitude,
                      address: {localized_multi_line_address_display: ["somewhere"]}
                    }.to_json }

  subject{ Venue.new(JSON.parse(venue_json)) }
  describe "#to_s" do
    it "combines the name and address with newlines" do
      expect(subject.to_s).to eq(["a place","somewhere"].join("\r\n"))
    end
  end

  describe "#latitude" do
    it "extracts the latitude from the input json" do
      expect(subject.latitude).to eq(latitude)
    end
  end

  describe "#longitude" do
    it "extracts the longitude from the input json" do
      expect(subject.longitude).to eq(longitude)
    end 
  end
end
