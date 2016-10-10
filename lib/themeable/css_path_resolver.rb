require 'pathname'
require 'fileutils'
module Themeable
  class CssPathResolver
    
    attr_reader :theme
    def initialize(theme)
      @theme = theme
    end

    def resolve
      root_directory = File.join(theme.root_path, 'vendor')
      Dir["#{root_directory}/**/*.css"].each do |filename|
        contents = File.read(filename) if FileTest.file?(filename)
        # http://www.w3.org/TR/CSS2/syndata.html#uri
        url_regex = /url\((?!\#)\s*['"]?((?![a-z]+:)([^'"\)]*?)([?#][^'"\)]*)?)['"]?\s*\)/

        # Resolve paths in CSS file if it contains a url
        if contents =~ url_regex
          directory_path = Pathname.new(File.dirname(filename))
          .relative_path_from(Pathname.new(root_directory))

          # Replace relative paths in URLs with Rails asset_path helper
          new_contents = contents.gsub(url_regex) do |match|
            relative_path = $2
            params = $3
            image_path = directory_path.join(relative_path).cleanpath

            "asset-url('#{image_path}#{params}')"
          end

          # Replace CSS with ERB CSS file with resolved asset paths
          FileUtils.rm(filename)
          File.write(filename.gsub(/css$/, 'scss'), new_contents)
        end
      end
    end
  end
end

# ThemeColorAdmin::ResolveCssPath.new.resolve_css_paths('/Users/tao/projects/theme_color_admin/')