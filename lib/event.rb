require 'date'
require_relative '../lib/dark_sky_client.rb'
require_relative '../lib/forecast.rb'

class Event
  attr_reader :event_json

  def initialize(event_json)
    @event_json = event_json
  end

  def load
    venue
    forecast
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

  def rainy_event?
    forecast.rain?
  end

  def date
    parsed_datetime.strftime('%Y-%m-%d %I:%M %p')
  end

  private

  def venue
    @venue ||= EventBriteClient.new.venue_for(venue_id)
  end

  def dsclient
    @dsclient ||= DarkSkyClient.new(latitude: venue.latitude,longitude: venue.longitude, datetime: datetime)
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
