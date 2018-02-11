require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true

    config.assets.paths << Rails.root.join("vendor","assets", "fonts")


 #   config.action_controller.asset_host = 'localhost:3000'
 #   config.action_mailer.asset_host = 'http://localhost:3000'

    config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 =>  587, # 25,
      :domain               => 'gmail.com',
      :user_name            => 'predios.smtp@gmail.com', # 'sistemas',
      :password             =>  ENV["email_password"],
      :authentication       => 'plain',
      #:ssl => true,
      :enable_starttls_auto => true, # Si lo colocaba en true daba este error= OpenSSL::SSL::SSLError (hostname does not match the server certificate)
       #      :openssl_verify_mode  => OpenSSL::SSL::VERIFY_CLIENT_ONCE,
    }


  end
end
