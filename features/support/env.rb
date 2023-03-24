require 'dotenv/load'
require 'capybara/cucumber'
require 'pry'
require 'factory_bot'
require 'active_support'
require 'active_support/core_ext'
World(FactoryBot::Syntax::Methods)
