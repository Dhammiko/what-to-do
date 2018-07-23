require 'curb'
require 'json'

# acess the dark sky API
class DarkSkyClient
  attr_reader :latitude, :longitude, :datetime

  def initialize(latitude:, longitude:, datetime:)
    @latitude = latitude
    @longitude = longitude
    @datetime = datetime
  end

  def fetch_weather_json
    curb = Curl::Easy.new(url)
    curb.ssl_verify_peer = false
    curb.perform
    JSON.parse(curb.body_str)
  end

  private

  def url
    "https://api.darksky.net/forecast/#{token}/#{latitude},#{longitude},#{epochtime}?exclude=currently,minutely,daily,flags,alerts"
  end

  def token
    CONFIG['dark_sky_token']
  end

  def epochtime
    DateTime.parse(datetime).strftime('%s')
  end
end
