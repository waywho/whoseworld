const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/components/*.rb',
    './app/components/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/assets/stylesheets/**/*.scss',
    './app/javascript/**/*.js',
    './config/initializers/simple_form_tailwind.rb',
    './node_modules/flowbite/**/*.js',
    './config/locales/**/*.yml'
  ],
  plugins: [
    require("../vendor/javascript/flowbite/plugin.js")
  ],
  theme: {
    listStyleType: {
      none: 'none',
      disc: 'disc',
      decimal: 'decimal',
      square: 'square'
    },
    extend: {
      fontFamily: {
        'display': ['League\\ Spartan', 'Helvetica', 'Arial', 'sans-serif']
      }
    }
  }
}
