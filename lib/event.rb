require 'date'
require_relative '../lib/dark_sky_client.rb'
require_relative '../lib/forecast.rb'

class Event
  attr_reader :event_json

  def initialize(event_json)
    @event_json = event_json
  end

  def to_s
    return [] if rainy_event
    [name,formatted_date,venue.to_s,forecast.to_s,"\r\n"].join("\r\n")
  end

  private

  def rainy_event
    forecast.rain?
  end

  def dsclient
    @dsclient ||= DarkSkyClient.new(latitude: venue.latitude,longitude: venue.longitude, datetime: datetime)
  end

  def forecast
    @forecast ||= Forecast.new(forecast_json: dsclient.fetch_weather_json, datetime: datetime)
  end

  def venue
    @venue ||= EventBriteClient.new.venue_for(venue_id)
  end

  def venue_id
    event_json['venue_id']
  end

  def name
    event_json['name']['text'].strip
  end

  def datetime 
    parsed_datetime.strftime('%Y-%m-%d')
  end

  def formatted_date
    parsed_datetime.strftime('%Y-%m-%d %I:%M %p')
  end

 def parsed_datetime
    DateTime.parse(event_json['start']['local'])
  end
end
