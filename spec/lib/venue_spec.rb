# frozen_string_literal: true

require 'rails_helper'

describe WhatToDo::Venue do
  let(:latitude) { '3' }
  let(:longitude) { '-7' }
  let(:venue_name) { 'fraggle hall' }
  let(:venue_address) { 'fraggle rock' }
  let(:venue_json) do
    { name: venue_name,
      latitude: latitude,
      longitude: longitude,
      address: { localized_multi_line_address_display: [venue_address] } }.to_json
  end

  subject { WhatToDo::Venue.new(JSON.parse(venue_json)) }

  describe '#name' do
    it 'extracts the venue name' do
      expect(subject.name).to eq(venue_name)
    end
  end

  describe '#address' do
    it 'extracts the venue address' do
      expect(subject.address).to eq([venue_address])
    end

    it 'does not raise when the address is nil' do
      parsed_json = JSON.parse(venue_json)
      parsed_json['address']['localized_multi_line_address_display'] = nil

      expect { WhatToDo::Venue.new(parsed_json).address }.to_not raise_error
    end
  end

  describe '#latitude' do
    it 'extracts the latitude from the input json' do
      expect(subject.latitude).to eq(latitude)
    end
  end

  describe '#longitude' do
    it 'extracts the longitude from the input json' do
      expect(subject.longitude).to eq(longitude)
    end
  end
end
