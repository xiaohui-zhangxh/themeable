require 'rails'
module Themeable
  class Railtie < Rails::Railtie

    config.to_prepare do
      ActionController::Base.send :include, Themeable::ActsAsThemeable
    end

    initializer :themeable do
      config.app_generators.theme = Themeable.default_theme if Themeable.default_theme
      Themeable.themes.each do |theme|

        config.assets.paths << File.join(theme.root_path, theme.theme_path, 'assets')
        config.assets.paths << File.join(theme.root_path, 'vendor')
        config.assets.precompile << /\A#{Regexp.escape(theme.theme_name)}\/[^\/]+\.(js|css)\z/
        config.assets.precompile << /\A#{Regexp.escape(theme.theme_name)}\/.+\.(gif|jpg|png|svg)\z/
      end
    end

    generators do |app|
      require 'themeable/generator_concern'
      require 'rails/generators/erb/scaffold/scaffold_generator'
      Erb::Generators::ScaffoldGenerator.send :include, Themeable::GeneratorConcern
      Themeable.themes.each do |theme|
        Erb::Generators::ScaffoldGenerator.source_paths << File.join(theme.root_path, theme.theme_path, 'scaffold_templates')
      end
    end

  end
end

