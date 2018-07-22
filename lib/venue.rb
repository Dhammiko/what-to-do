class Venue
  attr_reader :venue_json

  def initialize(venue_json)
    @venue_json = venue_json
  end

  def to_s
    [name,address].compact.join("\r\n")
  end

  def latitude
    venue_json['latitude']
  end

  def longitude
    venue_json['longitude']
  end

  private

  def name
    venue_json['name']
  end

  def address
    venue_json['address']['localized_multi_line_address_display'].map(&:strip)
  end
end
