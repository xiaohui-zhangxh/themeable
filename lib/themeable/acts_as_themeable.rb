module Themeable
  module ActsAsThemeable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_themeable(theme_name)
        instance_eval do
          before_filter :insert_theme_view_path
        end

        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          private
          def insert_theme_view_path
            view_paths = lookup_context.view_paths.to_a.map(&:to_path)
            theme = Themeable.theme("#{theme_name}")
            theme_view_path = File.join(theme.path, 'views')
            lookup_context.view_paths = view_paths.insert(1, theme_view_path)
          end
        RUBY
      end
    end
  end
end
