# Appraisal integrates with bundler and rake to test your library
# against different versions of dependencies in repeatable scenarios called "appraisals"
# https://github.com/thoughtbot/appraisal
#
# The dependencies in your Appraisals file are combined with dependencies in your Gemfile
#
# Install the dependencies for each appraisal
# $ bundle exec appraisal install
# which generates a Gemfile for each appraisal in the gemfiles directory
#
# Run each appraisal in turn or a single appraisal:-
# $ bundle exec appraisal rspec
# $ bundle exec appraisal rails-6-1 rspec
appraise "rails-6-1" do
  gem "rails", "~> 6.1"
  gem "sqlite3", '~> 1.4.0'
end

appraise "rails-6-0" do
  gem "rails", "~> 6.0.1"
  gem "sqlite3", '~> 1.4.0'
end

appraise "rails-5-2" do
  gem "rails", "~> 5.2"
  gem "sqlite3", '~> 1.3.0'
end

appraise "rails-5-1" do
  gem "rails", "~> 5.1.0"
  gem "sqlite3", '~> 1.3.0'
end

appraise "rails-5-0" do
  gem "rails", "~> 5.0.1"
  gem "sqlite3", '~> 1.3.0'
end

appraise "rails-4-2" do
  gem "rails", "~> 4.2"
  gem "sqlite3", '~> 1.3.0'
end

# appraise "rails-4-1" do
#   gem "rails", "~> 4.1.0"
# end
