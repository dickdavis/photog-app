# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PhotogApp
  ##
  # = Application
  # Author::    Richard Davis
  # Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
  # License::   GNU Public License 3
  #
  # The rails application.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Central Time (US & Canada)'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end
