run "curl https://raw.githubusercontent.com/fdel15/rails_template/master/Gemfile > Gemfile"
run "bundle install"

environment do
  <<-CODE
      # Use postgres UUIDs for id field
      config.generators do |generator|
        generator.orm :active_record, primary_key_type: :uuid
      end

      # Typescript Configuration
      # Recommended to add ts and tsx to the server_renderer_extensions in your
      # application configuration
      # https://github.com/reactjs/react-rails
      config.react.server_renderer_extensions = %w[jsx js tsx ts]

      # Camelize props when using generator
      config.react.camelize_props = true
  CODE
end

# RSPEC

run "rails generate rspec:install"

file 'spec/spec_helper.rb', File.read('spec_helper.rb')
file 'spec/rails_helper.rb', File.read('rails_helper.rb')

run "mkdir spec/support"

file 'spec/support/factory_bot.rb', File.read('factory_bot.rb')
file 'spec/support/shoulda_matchers', File.read('shoulda_matchers')

# REACT
# Helpful link https://www.freecodecamp.org/news/how-to-create-a-rails-project-with-a-react-and-redux-front-end-8b01e17a1db/

run "rails webpacker:install:typescript"
run "rails webpacker:install:react"
run "rails generate react:install"
run "yarn add @types/react @types/react-dom"
run "npm install --save react-router-dom yarn install"
run "npm install --save redux babel-polyfill reselect react-redux yarn install"
run "npm install --save redux-thunk yarn install"
run "npm install --save semantic-ui-css semantic-ui-react yarn install"

file 'app/javascript/packs/application.js', File.read('application.js')
