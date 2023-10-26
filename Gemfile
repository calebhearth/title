source 'https://rubygems.org'

rails_version = ENV.fetch("RAILS_VERSION", "7.1")

if rails_version == "main"
  rails_constraint = { github: "rails/rails" }
else
  rails_constraint = "~> #{rails_version}.0"
end

gem "rails", rails_constraint

# Specify your gem's dependencies in title.gemspec
gemspec
