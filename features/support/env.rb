ENV['RACK_ENV'] = 'test'
app_file = File.join(File.dirname(__FILE__), *%w[.. .. app.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
Sinatra::Application.app_file = app_file

require 'byebug'
require 'capybara/cucumber'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'factory_girl'
require 'rack/test'
require 'rspec/expectations'

require 'spec/factories'

Capybara.app = Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first

DatabaseCleaner[:sequel, {:connection => Sequel.connect(ENV['DATABASE_URL'])}]
DatabaseCleaner.strategy = :truncation

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

class CityGramWorld
  include Rack::Test::Methods
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
end

World { CityGramWorld.new }
