require 'themeable'
require 'theme_<%= theme_name %>/version'

module <%= app_name.camelize %>
  include Themeable::Theme
  set_name '<%= theme_name %>'
  set_path File.expand_path('../../theme', __FILE__)
end
