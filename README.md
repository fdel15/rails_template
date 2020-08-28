# rails_template
Template for creating a new project using Ruby on Rails.

The template performs the following configuraiton steps:
- configures `postgres` as database
- sets primary_key_type to `:uuid`
- installs `rspec` as testing framework instead of test unit
  - Rspec default configurations can be found in `spec_helper.rb` and `rails_helper.rb`
- installs `factory_bot` with `shoulda_matchers`
- installs `webpacker/react` FE
- installs `typescript`
- installs `react-router`
- installs `react-redux`
- installs `redux-thunk`
- installs `semantic-ui-css`
- Creates a private repository for github user specified in ENV variables and pushes the new project with an Initial Commit after everything is installed.
- Moves rails project to output destination if specified in the env variable.

## How to use
- Pull down repository
- create `.env` file in project root and export the following variables: 
  - `GITHUB_TOKEN` - needs to grant ability to create repositories (required)
  - `GITHUB_USER` - script will create a private repository for this user (required)
  - `OUTPUT_DIRECTORY` - output destination where rails project will exist on local machine (optional)
- Run `source .env` to pull in your ENV variables
- Run `rails new <project_name>`

## How to modify

This template will consistently be a work in progress. You should tweak all elements of this project to fit your specific needs.

Overtime, I expect more features to be added to this template as I continue to refine my skillset. For example, I plan on adding default `graphql` installation and a default `aws` configuration in the near future.

## TODO
- make template modular
  - you should be able to opt in to each part of the template on initialization of the rails project
  - you should be able to install any section after initialization of the project
