require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RestaurantReservationVue
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += %W(#{config.root}/app)
    config.autoload_paths += %W(#{config.root}/lib)

    config.action_cable.mount_path = '/cable'
    config.action_cable.disable_request_forgery_protection = !Rails.env.production?

    config.assets.paths << Rails.root.join('public')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
