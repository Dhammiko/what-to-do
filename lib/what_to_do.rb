require_relative '../lib/event_brite_client.rb'
require_relative '../lib/event.rb'

class WhatToDo
  attr_reader :zipcode, :datetime

  def initialize(args)
    @zipcode = args[0]
    @datetime = get_date(args)
    raise InvalidZip unless valid_zipcode?
  end

  def print_events
    print_delay_message
    threads = Array.new
    get_events.each do |event|
      break if threads.count >= max_events
      threads << Thread.new {
        puts event&.to_s
      }
    end
    threads.map!(&:join)
  end

  private

  def print_delay_message
    puts "One moment while I look up a few fair weather events in #{zipcode} around " + datetime.strftime("%m/%d") 
    puts "Powered by Eventbrite and Dark Sky"
    puts "\r\n\r\n"
  end

  def max_events
   25 
  end

  def get_date(args)
    if date_string = args[1]
      DateTime.parse(date_string)
    else
      DateTime.now
    end
  end

  def get_events
    events = Array.new
    EventBriteClient.new.events_for(zipcode: zipcode, datetime: datetime).each do |raw_event|
      events << Event.new(raw_event)
    end
    events
  end

  def valid_zipcode?
    (zipcode.to_s =~ /\d{5}/) == 0
  end
end

class InvalidZip < StandardError; end
