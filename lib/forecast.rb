# an object to hold the weater forecast for a venue at a certain date
class Forecast
  attr_reader :forecast_json, :datetime

  def initialize(forecast_json:, datetime:)
    @forecast_json = forecast_json
    @datetime = datetime
  end

  def rain?
    !forecast.scan(/rain/i)[0].nil?
  end

  def forecast
    forecast_json['hourly']['data'][hour_of_day]['summary']
  end

  private

  def hour_of_day
    DateTime.parse(datetime).strftime('%H').to_i
  end
end
