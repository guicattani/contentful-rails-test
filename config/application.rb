# frozen_string_literal: true
require_relative "boot"

require "rails"
require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Mspoon
  class Application < Rails::Application
    config.load_defaults 7.0
    config.generators.system_tests = nil

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += Dir["#{config.root}/app/models/**/"]

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
