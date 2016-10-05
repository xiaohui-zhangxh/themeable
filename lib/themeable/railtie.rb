require 'rails'
module Themeable
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActionController::Base.send :include, Themeable::ActsAsThemeable
    end
    initializer :themeable do
      # puts "== Themeable =="
      Themeable.themes.each do |theme|
        config.assets.paths << File.join(theme.path, 'assets')
        config.assets.precompile << /\A#{Regexp.escape(theme.name)}\/[^\/]+\.(js|css)\z/
        config.assets.precompile << /\A#{Regexp.escape(theme.name)}\/.+\.(gif|jpg|png|svg)\z/
      end
    end
  end
end
