require 'rails'
module Themeable
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActionController::Base.send :include, Themeable::ActsAsThemeable
    end
    initializer :themeable do
      Themeable.themes.each do |theme|
        config.assets.paths << File.join(theme.path, 'assets')
        config.assets.precompile << /\A#{Regexp.escape(theme.name)}\//
      end
    end
  end
end
