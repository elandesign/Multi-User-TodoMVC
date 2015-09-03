# Boot file for all environments. See also ApplicationController for base app config.

# Defaults are good
ENV["RACK_ENV"] ||= "development"

# Sort bundler out, based on RACK_ENV
require "bundler"
Bundler.setup(:default, ENV["RACK_ENV"].to_sym)

# Should be able to require stuff from app/ & lib/
$LOAD_PATH.unshift File.expand_path(File.join("..", "app"), File.dirname(__FILE__))

require "sinatra"
require "sinatra/reloader" if ENV["RACK_ENV"] == "development"
require "sinatra/sequel"
require "sinatra/resources"
require "json"
require "sprockets"
require "sprockets-helpers"
require "sprockets/es6"
require "font-awesome-sass"
require "pry"

if ENV["RACK_ENV"] == "test"
  # Use an in-memory database
  DB = Sequel.sqlite
else
  DB = Sequel.connect("sqlite://db/#{ENV["RACK_ENV"]}.db")
end

unless DB.table_exists?("lists")
  DB.create_table :lists do
    primary_key :id
    String      :name
  end
end

unless DB.table_exists?("items")
  DB.create_table :items do
    primary_key :id
    Integer     :list_id
    String      :name
    FalseClass  :complete, default: false
  end
end

require "models/list"
require "models/item"
require "controllers/application_controller"
