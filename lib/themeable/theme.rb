module Themeable

  # Theme's basic module, automatically define methods
  #   - name
  #   - root_path
  #   - theme_path
  module Theme
    def self.included(subclass)

      Themeable.add_theme(subclass)

      # set default values
      caller_file = caller.first
      if caller_file =~ %r{/theme_(.+?)/lib/theme_\1\.rb}
        default_name = $1.to_sym
        default_root = File.expand_path(File.join(caller_file, '../../'))
      end

      subclass.instance_eval <<-RUBY, __FILE__, __LINE__ + 1
        @name = #{default_name.inspect}

        # Theme name
        #
        # @return [Symbol]
        def name
          @name || raise("Theme name is no defined")
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

        protected

        # Set theme name
        #
        # @param [String] name
        # @return [Symbol] symbolized name
        def set_name(name)
          @name = name.to_sym
        end

        # Set root path of theme project
        #
        # @param [String] path
        # @return [String]
        def set_root_path(path)
          @root_path = path
        end

        # Set theme's relative path, which path includes assets and views
        #
        # @param [String] path is a relative path where assets and views locate.
        # @return [String]
        def set_theme_path(path)
          @theme_path = theme_path
        end

      RUBY
    end
  end
end
