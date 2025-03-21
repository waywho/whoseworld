source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.2.2.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.0"

gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# MailTrap
gem "mailtrap"

# Add to calendar url in mailer
gem "add_to_calendar"

# # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
# gem "cssbundling-rails"

gem "tailwindcss-rails"
gem "flowbite", "~> 2.3"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
#
gem "nilify_blanks"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 5.3"

# Acts as tenant
# gem "acts_as_tenant"

# Row order
gem "ranked-model"

# Tagging
gem "acts-as-taggable-on"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# simple form
gem "simple_form"

# user authentication
gem "devise"

# Recaptcha
gem "recaptcha"

# admin interface
gem "activeadmin", "~> 4.0.beta15"

# friendly id
gem "friendly_id"

# Open Street Map
gem "open_street_map"

# ViewComponent
gem "view_component"
gem "lookbook", "~> 2.3.4"
gem "nice_partials"

# Haml
gem "haml-rails", "~> 2.1.0"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

gem "aws-sdk-s3", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem "rails-controller-testing"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem "foreman"

  gem "letter_opener"

  gem "pry-remote"

  gem "listen"
  gem "actioncable"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "cuprite"
end

gem "dockerfile-rails", ">= 1.6", :group => :development
