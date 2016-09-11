require 'themeable/version'
require 'themeable/railtie'
require 'themeable/acts_as_themeable'

module Themeable
  
  mattr_accessor :themes
  @@themes = {}

  def self.theme(theme_name)
    themes[theme_name.to_sym] || raise("Theme #{theme_name} not found")
  end

  def self.add_theme(theme_name, path)
    themes[theme_name.to_sym] = File.expand_path(path)
  end

end
