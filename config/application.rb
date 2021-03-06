require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StockAppRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    ActionMailer::Base.smtp_settings = {
      user_name:      'stockapprails@gmail.com',
      password:       'xkssbmvxpqdxcbfc',
      domain:         'gmail.com',
      address:        'smtp.gmail.com',
      port:           587,
      authentication: 'plain',
      enable_starttls_auto: true
    }

    IEX::Api.configure do |config|
      config.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN']
      config.secret_token = ENV['IEX_API_SECRET_TOKEN']
      config.endpoint = 'https://cloud.iexapis.com/v1'
    end
  end
end
