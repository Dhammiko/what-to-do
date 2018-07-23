module Client
  # a client for accessing event brite event data
  class EventBriteClient
    attr_reader :zipcode, :venue_id, :datetime

    def initialize; end

    def events_for(zipcode:, datetime:)
      @zipcode = zipcode
      @datetime = datetime
      fetch_events['events']
    end

    def venue_for(venue_id)
      @venue_id = venue_id
      WhatToDo::Venue.new(fetch_venue)
    end

    private

    def fetch_venue
      get_json(venue_url)
    end

    def fetch_events
      get_json(events_url)
    end

    def get_json(url)
      curb = Curl::Easy.new(url)
      curb.ssl_verify_peer = false
      curb.perform
      JSON.parse(curb.body_str)
    end

    def venue_url
      "#{host}venues/#{venue_id}/?token=#{token}"
    end

    def events_url
      "#{host}events/search/?token=#{token}&location.address=#{zipcode}&start_date.range_start=#{events_start_date}&start_date.range_end=#{events_end_date}"
    end

    def token
      CONFIG['event_brite_token']
    end

    def host
      'https://www.eventbriteapi.com/v3/'
    end

    def events_start_date
      format_date(datetime)
    end

    def events_end_date
      format_date(datetime + default_lookahead_days)
    end

    def default_lookahead_days
      CONFIG['default_lookahead_days']
    end

    def format_date(date)
      date.strftime('%Y-%m-%dT%H:%M:%S')
    end
  end
end
