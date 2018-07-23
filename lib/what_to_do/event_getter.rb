module WhatToDo
  # given a zipcode and date get interesting event objects
  class EventGetter
    attr_reader :zipcode, :datetime

    def initialize(args)
      @zipcode = args['zipcode']
      @datetime = get_date(args['datetime'])
      raise Exceptions::InvalidZip unless valid_zipcode?
    end

    def get_events
      threads = []
      eventbrite_events.each do |event|
        break if threads.count >= max_events
        threads << Thread.new do
          event.load
        end
      end
      threads.map!(&:join).map!(&:value).compact
    end

    private

    def eventbrite_events
      events = []
      Client::EventBriteClient.new.events_for(zipcode: zipcode, datetime: datetime).each do |raw_event|
        events << Event.new(raw_event)
      end
      events
    end

    def max_events
      CONFIG['max_events']
    end

    def get_date(date_string)
      date_string.present? ? DateTime.parse(date_string) : DateTime.now
    rescue ArgumentError
      raise Exceptions::InvalidDate
    end

    def valid_zipcode?
      (zipcode.to_s =~ /\d{5}/) == 0
    end
  end
end
