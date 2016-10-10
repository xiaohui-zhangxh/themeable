module Themeable

  # Theme's basic module, automatically define methods
  #   - theme_name
  #   - root_path
  #   - theme_path
  module Theme
    def self.included(subclass)

      Themeable.add_theme(subclass)

      # set default values
      caller_file = caller.first
      if caller_file =~ %r{/lib/theme_([^/]*)\.rb}
        default_theme_name = $1.to_sym
        default_root = File.expand_path(File.join(caller_file, '../../'))
      end

      subclass.instance_eval <<-RUBY, __FILE__, __LINE__ + 1
        @theme_name = #{default_theme_name.inspect}

        # Theme name
        #
        # @return [Symbol]
        def theme_name
          @theme_name || raise("Theme name can't be resolved from path: #{__FILE__}")
        end

        @root_path = #{default_root.inspect}

        # Theme project's root path
        #
        # @return [String]
        def root_path
          @root_path || raise("Theme project's root path is no defined")
        end

        # Theme's relative path, 'theme' by default
        #
        # @return [String] default is 'theme'
        def theme_path
          @theme_path || 'theme'
        end

      RUBY
    end
  end
end
