require 'themeable'
require 'theme_<%= theme_name %>/version'

module <%= app_name.camelize %>
  include Themeable::Theme
  # set_name '<%= theme_name %>' # by default, resovle name by file path automatically
  # set_root_path File.expand_path('../..', __FILE__)
  # set_theme_path 'theme'
end
