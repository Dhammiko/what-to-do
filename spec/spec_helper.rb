require_relative '../lib/what_to_do.rb'
require_relative '../lib/event.rb'
require_relative '../lib/venue.rb'
require_relative '../lib/forecast.rb'
require_relative '../lib/event_brite_client.rb'
require_relative '../lib/dark_sky_client.rb'

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
