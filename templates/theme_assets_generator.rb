module Themeable
  module <%= theme_name.camelize %>
    class AssetsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../../theme", __FILE__)
      def copy_assets
        directory 'assets', 'app/assets/themes'
      end
    end
  end
end
