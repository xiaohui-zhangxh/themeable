module Theme<%= theme_name.camelize %>
  module Generators
    class CopyAssetsGenerator < Rails::Generators::Base
      source_root File.join(Theme<%= theme_name.camelize %>.root_path, 'theme')
      def copy_assets
        directory 'assets', 'app/assets/themes'
      end
    end
  end
end

