# Boot file for all environments. See also ApplicationController for base app config.

# Defaults are good
ENV["RACK_ENV"] ||= "development"

# Sort bundler out, based on RACK_ENV
require "bundler"
Bundler.setup(:default, ENV["RACK_ENV"].to_sym)

# Should be able to require stuff from app/ & lib/
$LOAD_PATH.unshift File.expand_path(File.join("..", "app"), File.dirname(__FILE__))

require "sinatra"
require "sinatra/sequel"
require "sinatra/resources"
require "json"
require "sprockets"
require "sprockets-helpers"
require "sprockets-sass"
require "pry"

set :database, "sqlite://db/#{ENV["RACK_ENV"]}.db"

migration "create lists" do
  database.create_table :lists do
    primary_key :id
    String      :name
  end
end

migration "create items" do
  database.create_table :items do
    primary_key :id
    Integer     :list_id
    String      :name
    FalseClass  :complete
  end
end

require "models/list"
require "models/item"
require "controllers/application_controller"
