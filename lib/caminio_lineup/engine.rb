require "caminio"

module CaminioLineup
  class Engine < ::Rails::Engine

    isolate_namespace Caminio
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[File.join( File.expand_path('../../../',__FILE__), 'app', 'api')]

    config.paths.add File.join('app', 'entities'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[File.join( File.expand_path('../../../',__FILE__), 'app', 'entities')]

    # rspec
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( lineup.js 
                                                        lineup.css )
    end


  end
end
