# Build Active Admin CSS with Tailwind v4 standalone CLI (no npm required).
# Uses @plugin to load the ActiveAdmin Tailwind plugin directly from the gem.

namespace :active_admin do
  desc "Build Active Admin Tailwind stylesheets"
  task build: :environment do
    active_admin_path = Gem.loaded_specs["activeadmin"].full_gem_path
    input = Rails.root.join("tmp/active_admin_input.css")
    output = Rails.root.join("app/assets/builds/active_admin.css")

    File.write(input, <<~CSS)
      @import "tailwindcss";
      @plugin "#{active_admin_path}/plugin.js";
      @source "#{active_admin_path}/vendor/javascript/flowbite.js";
      @source "#{active_admin_path}/plugin.js";
      @source "#{active_admin_path}/app/views/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/admin/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/views/active_admin/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/views/admin/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/views/layouts/active_admin*.{erb,html}";
      @source "#{Rails.root}/app/javascript/**/*.js";
    CSS

    system(
      Rails.root.join("bin/tailwindcss").to_s,
      "-i", input.to_s,
      "-o", output.to_s,
      "-m",
      exception: true
    )
  end

  desc "Watch Active Admin Tailwind stylesheets"
  task watch: :environment do
    active_admin_path = Gem.loaded_specs["activeadmin"].full_gem_path
    input = Rails.root.join("tmp/active_admin_input.css")
    output = Rails.root.join("app/assets/builds/active_admin.css")

    File.write(input, <<~CSS)
      @import "tailwindcss";
      @plugin "#{active_admin_path}/plugin.js";
      @source "#{active_admin_path}/vendor/javascript/flowbite.js";
      @source "#{active_admin_path}/plugin.js";
      @source "#{active_admin_path}/app/views/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/admin/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/views/active_admin/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/views/admin/**/*.{arb,erb,html,rb}";
      @source "#{Rails.root}/app/views/layouts/active_admin*.{erb,html}";
      @source "#{Rails.root}/app/javascript/**/*.js";
    CSS

    system(
      Rails.root.join("bin/tailwindcss").to_s,
      "-i", input.to_s,
      "-o", output.to_s,
      "--watch",
      exception: true
    )
  end
end

Rake::Task["assets:precompile"].enhance(["active_admin:build"])

Rake::Task["test:prepare"].enhance(["active_admin:build"]) if Rake::Task.task_defined?("test:prepare")
Rake::Task["spec:prepare"].enhance(["tailwindcss:build"]) if Rake::Task.task_defined?("spec:prepare")
Rake::Task["db:test:prepare"].enhance(["tailwindcss:build"]) if Rake::Task.task_defined?("db:test:prepare")
