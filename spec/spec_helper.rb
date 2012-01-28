require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  # require rspec support files
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    # drop databases before each spec
    config.before(:each) do
      Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    end
  end

end

Spork.each_run do
  # Anything that needs to be run each time goes here.
end