require_relative "config/boot"

run Rack::URLMap.new(
  ApplicationController.assets_prefix => ApplicationController.sprockets,
  '/' => ApplicationController,
)
