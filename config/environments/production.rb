# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
#config.action_controller.page_cache_directory = RAILS_ROOT + "/public"  
config.action_controller.cache_store = [:file_store, "#{RAILS_ROOT}/tmp/cache"]
#config.cache_store = :mem_cache_store, '127.0.0.1', { :namespace => RAILS_ENV.to_s, :username => "nobody", :timeout => nil }
# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
ActionMailer::Base.delivery_method = :sendmail
config.action_mailer.raise_delivery_errors = false
config.action_mailer.sendmail_settings = { :location  => "/usr/sbin/sendmail", :arguments => "-i -t" }
config.action_mailer.perform_deliveries = true