class Event
  attr_reader :event_json

  def initialize(event_json)
    @event_json = event_json
  end

  def load
    !rainy_event? ? self : nil
  end

  def name
    event_json['name']['text'].strip
  end

  def venue_name
    venue.name
  end

  def venue_address
    venue.address
  end

  def weather_forecast
    forecast.forecast
  end

  def date
    parsed_datetime.strftime(output_date_format)
  end

  private

  def rainy_event?
    forecast.rain?
  end

  def output_date_format
    CONFIG['output_date_format']
  end

  def venue
    @venue ||= EventBriteClient.new.venue_for(venue_id)
  end

  def dsclient
    @dsclient ||= DarkSkyClient.new(latitude: venue.latitude, longitude: venue.longitude, datetime: datetime)
  end

  def forecast
    @forecast ||= Forecast.new(forecast_json: dsclient.fetch_weather_json, datetime: datetime)
  end

  def venue_id
    event_json['venue_id']
  end

  def datetime
    parsed_datetime.strftime('%Y-%m-%d')
  end

  def parsed_datetime
    DateTime.parse(event_json['start']['local'])
  end
end
