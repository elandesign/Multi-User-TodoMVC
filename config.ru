require_relative "config/boot"

run Rack::URLMap.new(
  '/' => ApplicationController
)
