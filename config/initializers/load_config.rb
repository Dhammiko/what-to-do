# config/initializers/load_config.rb
CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
