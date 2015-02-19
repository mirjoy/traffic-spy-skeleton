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

DatabaseCleaner.strategy = :truncation
Capybara.app = TrafficSpy::Server
