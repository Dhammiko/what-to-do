class WhatToDo
  attr_reader :zipcode, :datetime

  def initialize(args)
    @zipcode = args['zipcode']
    @datetime = get_date(args['datetime'])
    raise Exceptions::InvalidZip unless valid_zipcode?
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

  def get_events
    events = Array.new
    EventBriteClient.new.events_for(zipcode: zipcode, datetime: datetime).each do |raw_event|
      events << Event.new(raw_event)
    end
    events
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

  def get_date(date_string)
    date_string ?  DateTime.parse(date_string) : DateTime.now
  rescue ArgumentError
    raise Exceptions::InvalidDate
  end

  def valid_zipcode?
    (zipcode.to_s =~ /\d{5}/) == 0
  end
end
