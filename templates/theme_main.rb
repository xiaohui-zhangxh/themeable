require 'themeable'
require 'theme_<%= theme_name %>/version'

module <%= app_name.camelize %>
  include Themeable::Theme
end
