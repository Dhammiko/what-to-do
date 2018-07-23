# frozen_string_literal: true

module WhatToDo
  # an object tto hold information about the venue for an event
  class Venue
    attr_reader :venue_json

    def initialize(venue_json)
      @venue_json = venue_json
    end

    def latitude
      venue_json['latitude']
    end

    def longitude
      venue_json['longitude']
    end

    def name
      venue_json['name']
    end

    def address
      return [] unless (address = venue_json['address']['localized_multi_line_address_display'])
      address.map(&:strip)
    end
  end
end
