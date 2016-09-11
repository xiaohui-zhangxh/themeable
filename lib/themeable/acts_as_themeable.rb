module Themeable
  module ActsAsThemeable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_themeable(theme_name)
        theme = Themeable.theme(theme_name)
        class_eval do
          prepend_view_path "#{theme.path}/views"
        end
      end
    end
  end
end
