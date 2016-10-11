module Theme<%= theme_name.camelize %>
  module Generators
    class CopyViewsGenerator < Rails::Generators::Base
      source_root File.join(Theme<%= theme_name.camelize %>.root_path, 'theme')
      def copy_views
        directory 'views', 'app/themes/<%= theme_name %>'

        root = self.class.source_root
        template_engine = Rails.application.config.app_generators.rails[:template_engine] || 'erb'
        Dir.glob(File.join(root, "scaffold_templates/<%= theme_name %>/**/*.#{template_engine}")) do |file|
          source_path = Pathname.new(file).relative_path_from(Pathname.new(root))
          destination_path = Pathname.new(file).relative_path_from(Pathname.new(File.join(root, 'scaffold_templates/<%= theme_name %>')))
          copy_file source_path, "lib/templates/#{template_engine}/scaffold/<%= theme_name %>/#{destination_path}"
        end
      end
    end
  end
end

