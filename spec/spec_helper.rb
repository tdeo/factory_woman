$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_record'
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

require 'factory_girl'
require 'support/schema.rb'
require 'support/models'
require 'support/factories'
require 'factory_woman'
require 'database_cleaner'

RSpec.configure do |config|
  config.full_backtrace = false
  config.formatter = 'documentation'
  config.order = :random

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
