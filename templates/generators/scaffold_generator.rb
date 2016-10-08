require 'rails/generators/erb/scaffold/scaffold_generator'

module Theme<%= theme_name.camelize %>
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      class_option :scaffold_template, type: :string, default: 'default',
        desc: "Choose template to scaffold: default or admin"
      source_root File.join(Theme<%= theme_name.camelize %>.root_path, "theme/scaffold_templates")

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions view
          template "#{options[:theme_template]}/#{view}.html.erb", File.join('app', 'views', controller_file_path, filename)
        end
      end

      protected

      def available_views
        ['index', 'edit', 'show', 'new', '_form']
      end

      def handler
        :erb
      end

    end
  end
end

