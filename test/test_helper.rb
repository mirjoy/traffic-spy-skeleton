ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'database_cleaner'
require 'capybara'
require 'pry'
require 'json'

DatabaseCleaner.strategy = :transaction

class MiniTest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

Capybara.app = TrafficSpy::Server
