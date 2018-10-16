class EventGetter
  attr_reader :zipcode, :datetime

  def initialize(args)
    @zipcode = args['zipcode']
    @datetime = get_date(args['datetime'])
    raise Exceptions::InvalidZip unless valid_zipcode?
  end

  def get_events
    events.each do |event|
      Thread.new { event.load }
    end
  end

  private

  def events
    eventbrite_events.map do |event|
      Event.new(event)
    end
  end

  def eventbrite_events
    EventBriteClient.new.events_for(zipcode: zipcode, datetime: datetime)
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
