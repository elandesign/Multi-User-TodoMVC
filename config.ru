require_relative "config/boot"
require "rack/contrib"

use Rack::PostBodyContentTypeParser

run Rack::URLMap.new(
  ApplicationController.assets_prefix => ApplicationController.sprockets,
  '/' => ApplicationController,
)
