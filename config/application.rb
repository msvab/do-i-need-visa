require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module DoINeedVisa
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true

    if Rails.env.production?
      config.middleware.insert_before ActionDispatch::Static, Rack::SSL, :exclude => proc { |env| env['HTTPS'] != 'on' }
    end
  end
end
