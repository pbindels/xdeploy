require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Qdeploy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    
    config.from_file_with_scope 'qdeploy.yml', 'qdeploy'

    config.autoload_paths += %W(#{config.root}/lib/extras)

    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false, :views => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.orm :active_record
      g.scaffold_controller :scaffold_controller
    end

    # Rails.configuration.my_engine
    config.from_file_with_scope 'settings.yml', "my_scope"

  end
end
