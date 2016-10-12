require 'themeable/version'
require 'themeable/railtie'
require 'themeable/theme'
require 'themeable/acts_as_themeable'

module Themeable

  module_function

  @@theme_set = Set.new
  def add_theme(theme_class)
    @@theme_set << theme_class
  end

  def themes
    @@theme_set
  end

  def theme(theme_name)
    themes.find{|t| t.theme_name == theme_name.to_sym } || raise("Theme #{theme_name} not found")
  end

end
