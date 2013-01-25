Smartr::Application.configure do
  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
#  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.perform_deliveries = true

  config.active_support.deprecation = :log

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  config.secret_token ='94b9c594695e69bdef6b1d4be037af5853be976b39a52a02f260fca0d0a36a8f913572bfdb631f55971a3b10b8dd9a875f9776ca61371741544e6ccc064dd41e'
  
  # SMTP Configuration
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => "localhost:3000"}
  #config.action_mailer.smtp_settings = {
  #    :address              => "smtp.gmail.com",
  #    :port                 => 587,
  #    :domain               => 'gmail.com',
  #    :user_name            => 'rails3buch',
  #    :password             => 'VlJvV0DxZPoq7K',
  #    :authentication       => 'plain',
  #    :enable_starttls_auto => true
  #  }
  config.action_mailer.smtp_settings = { :host => "localhost", :port => 1025 }
  
  # Do not compress assets
    config.assets.compress = false

    # Expands the lines which load the assets
    config.assets.debug = true

  # Sunspot Solr
  Sunspot.config.solr.url = 'https://6823c2bdc2e-thermonuclear:ecd58f9abba@solr.hosted-solr.com/6823c2bdc2e-thermonuclear/core/'

end
require 'net/http'
