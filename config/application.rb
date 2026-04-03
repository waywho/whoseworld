require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whoseworld
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Berlin"
    config.hosts = nil
    config.importmap.paths << ActiveAdmin::Engine.root.join("config", "importmap.rb")

    config.view_component.generate_sidecar = true
    config.view_component.previews.paths << "#{Rails.root}/test/components/previews"
    config.view_component.default_preview_layout = "component_preview"
    config.view_component.generate.preview = true
  end
end
