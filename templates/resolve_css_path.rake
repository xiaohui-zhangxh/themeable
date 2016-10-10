require 'themeable/css_path_resolver'

namespace :resolve do
  desc "Resolve css paths from vendor"
  task :css_path do
    Themeable::CssPathResolver.new(Theme<%= theme_name.camelize %>).resolve
  end
end
