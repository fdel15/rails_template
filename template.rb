# frozen_string_literal: true
require 'byebug'

def app_name
  @app_name
end

def github_token
  ENV['GITHUB_TOKEN']
end

def github_user
  ENV['GITHUB_USER']
end

def github_url
  "https://#{github_user}:#{github_token}@github.com/#{github_user}/#{app_name}"
end

def create_github_repo
  "curl -X POST -H \"Authorization: token #{github_token}\" \
    -d '{\"name\": \"#{app_name}\", \"auto_init\": true, \"private\": true, \"gitignore_template\": \"Rails\"}' \
    https://api.github.com/user/repos"
end

file 'Gemfile', File.read('../Gemfile'), force: true
run 'bundle install'

environment do
  <<-CODE
      ##
      # Use postgres UUIDs for id field
      ##
      config.generators do |generator|
        generator.orm :active_record, primary_key_type: :uuid
      end

      ##
      # Typescript Configuration
      # Recommended to add ts and tsx to the server_renderer_extensions in your
      # application configuration
      # https://github.com/reactjs/react-rails
      ##
      config.react.server_renderer_extensions = %w[jsx js tsx ts]

      ##
      # Camelize props when using generator
      ##
      config.react.camelize_props = true
  CODE
end

# RSPEC

run 'echo -----------------------------------------------------'
run 'echo "RSPEC"'
run 'echo -----------------------------------------------------'
run 'bundle exec rails generate rspec:install'


file 'spec/spec_helper.rb', File.read('../rspec/spec_helper.rb'), force: true
file 'spec/rails_helper.rb', File.read('../rspec/rails_helper.rb'), force: true

run 'mkdir spec/support'

file 'spec/support/factory_bot.rb', File.read('../rspec/factory_bot.rb'), force: true
file 'spec/support/shoulda_matchers', File.read('../rspec/shoulda_matchers.rb'), force: true

# REACT
# Helpful link https://www.freecodecamp.org/news/how-to-create-a-rails-project-with-a-react-and-redux-front-end-8b01e17a1db/

run 'echo -----------------------------------------------------'
run 'echo "REACT"'
run 'echo -----------------------------------------------------'

# Ordering here matters. We need to install webpacker first, then react, and
# then typescript.
rails_command 'webpacker:install'
rails_command 'webpacker:install:react'
rails_command 'generate react:install'
rails_command 'webpacker:install:typescript'

run 'echo -----------------------------------------------------'
run 'echo "NPM"'
run 'echo -----------------------------------------------------'

run 'yarn add @types/react @types/react-dom'
run 'npm install --save react-router-dom yarn install'
run 'npm install --save redux babel-polyfill reselect react-redux yarn install'
run 'npm install --save redux-thunk yarn install'
run 'npm install --save semantic-ui-css semantic-ui-react yarn install'

file 'app/javascript/packs/application.js', File.read('../javascript/application.js'), force: true

git :init
git add: '.'
git commit: "-m 'Initial Commit'"

run create_github_repo

git remote: "add origin #{github_url}"
git push: 'origin master -f'