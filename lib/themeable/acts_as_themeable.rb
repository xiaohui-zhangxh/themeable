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
          def __themeable_theme_name
            #{theme_name.is_a?(Symbol) ? "send(:#{theme_name})" : "'#{theme_name}'"}
          end
          def insert_theme_view_path
            theme_name = __themeable_theme_name
            return if theme_name == :none
            view_paths = lookup_context.view_paths.to_a.map(&:to_path)
            theme = Themeable.theme(__themeable_theme_name)
            theme_view_path = File.join(theme.root_path, theme.theme_path, 'views')
            view_paths.insert(1, theme_view_path)
            view_paths.insert(0, Rails.root.join('app/themes/', theme_name).to_s)
            lookup_context.view_paths = view_paths
          end
        RUBY
      end
    end
  end
end
