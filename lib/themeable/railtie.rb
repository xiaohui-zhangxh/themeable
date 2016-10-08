require 'rails'
module Themeable
  class Railtie < Rails::Railtie

    config.to_prepare do
      ActionController::Base.send :include, Themeable::ActsAsThemeable
    end

    initializer :themeable do
      config.app_generators.template_engine Themeable.template_engine if Themeable.template_engine
      Themeable.themes.each do |theme|
        config.assets.paths << File.join(theme.root_path, theme.theme_path, 'assets')
        config.assets.paths << File.join(theme.root_path, 'vendor')
        config.assets.precompile << /\A#{Regexp.escape(theme.theme_name)}\/[^\/]+\.(js|css)\z/
        config.assets.precompile << /\A#{Regexp.escape(theme.theme_name)}\/.+\.(gif|jpg|png|svg)\z/
      end
    end

    generators do |app|
      Rails::Generators::ScaffoldControllerGenerator.class_option :scaffold_template, default: 'default', desc: 'Which scaffold template of themeable plugin you want to use'
    end

  end
end

