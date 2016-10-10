module Theme<%= theme_name.camelize %>
  module Generators
    class CopyViewsGenerator < Rails::Generators::Base
      source_root File.join(Theme<%= theme_name.camelize %>.root_path, 'theme')
      def copy_views
        directory 'views', 'app/views'
        directory 'scaffold_templates', 'lib/templates/theme_<%= theme_name %>/scaffold'
      end
    end
  end
end

