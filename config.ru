# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require_relative 'telegram_bot'

run Rails.application
