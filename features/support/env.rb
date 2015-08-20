ENV['RACK_ENV'] = 'test'
app_file = File.join(File.dirname(__FILE__), *%w[.. .. app.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
Sinatra::Application.app_file = app_file

require 'byebug'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'factory_girl'
require 'rack/test'
require 'rspec/expectations'
require 'webrat'

require 'spec/factories'

DatabaseCleaner[:sequel, {:connection => Sequel.connect(ENV['DATABASE_URL'])}]
DatabaseCleaner.strategy = :truncation

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include FactoryGirl::Syntax::Methods

  Webrat::Methods.delegate_to_session :response_code, :response_body

  def app
    Sinatra::Application
  end
end

World{MyWorld.new}
