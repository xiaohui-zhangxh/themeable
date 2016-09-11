require 'themeable/version'
require 'themeable/railtie'
require 'themeable/theme'
require 'themeable/acts_as_themeable'

module Themeable

  @@theme_set = Set.new
  def self.add_theme(theme_class)
    @@theme_set << theme_class
  end

  def self.themes
    @@theme_set
  end

  def self.theme(theme_name)
    themes.find{|t| t.name == theme_name.to_sym } || raise("Theme #{theme_name} not found")
  end

end
