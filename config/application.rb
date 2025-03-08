require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whoseworld
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.hosts = nil
    config.autoload_lib(ignore: %w(assets tasks))

    config.view_component.generate_sidecar = true
    # config.view_component.preview_paths << "#{Rails.root}/test/components/previews"
    config.view_component.default_preview_layout = "component_preview"
    config.view_component.generate.preview = true
  end
end
