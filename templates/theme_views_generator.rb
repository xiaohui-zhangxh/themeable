module Themeable
  module <%= theme_name.camelize %>
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../../theme", __FILE__)
      def copy_views
        directory 'views', 'app/views'
      end
    end
  end
end
