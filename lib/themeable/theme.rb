module Themeable
  module Theme
    def self.included(subclass)
      Themeable.add_theme(subclass)
      subclass.instance_eval <<-'RUBY'
        
        @name = nil
        def name
          @name || raise("Theme name is no defined")
        end

        @path = nil
        def path
          @path || raise("Theme path is no defined")
        end

        private

        def set_name(name)
          @name = name.to_sym
        end

        def set_path(path)
          @path = path
        end

      RUBY
    end
  end
end
