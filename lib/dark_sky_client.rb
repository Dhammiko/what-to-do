require 'curb'
require 'json'

class DarkSkyClient
  attr_reader :latitude,:longitude,:datetime

  def initialize(latitude:,longitude:,datetime:)
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
    "5a4714a803fd26697ef951505a512e34"
  end

  def epochtime
    DateTime.parse(datetime).strftime('%s')
  end
end
