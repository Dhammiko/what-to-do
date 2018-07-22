require 'what_to_do.rb'
require 'event.rb'
require 'venue.rb'
require 'forecast.rb'
require 'event_brite_client.rb'
require 'dark_sky_client.rb'

require 'net/http'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'factory_bot'
require 'ostruct'
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
