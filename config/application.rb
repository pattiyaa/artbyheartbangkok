require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Artbyheartbangkok
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
	config.assets.enabled = true
	
	config.assets.precompile += Ckeditor.assets
	# config.assets.precompile += %W(#{config.root}/app/models/ckeditor)
	# config.assets.precompile += %W(#{config.root}/app/assert/ckeditor)
	
  end
end
