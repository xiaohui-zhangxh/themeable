module Theme<%= theme_name.camelize %>
  module Generators
    class CopyViewsGenerator < Rails::Generators::Base
      source_root File.join(Theme<%= theme_name.camelize %>.root_path, 'theme')
      def copy_views
        directory 'views', 'app/themes/<%= theme_name %>'
        directory 'scaffold_templates/<%= theme_name %>', "lib/templates/#{Rails.application.config.app_generators.rails[:template_engine]}/scaffold/<%= theme_name %>"
      end
    end
  end
end

