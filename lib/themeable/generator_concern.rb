module Themeable
  module GeneratorConcern
    def self.included(klass)
      klass.instance_eval do
        class_option :theme, type: :string, desc: "Choose theme to generate files", default: nil
        class_option :theme_template, type: :string, desc: "Choose a templete to scaffold", default: nil
      end
    end

    # Support theme and template
    def find_in_source_paths(file)
      theme_template = options[:theme_template]
      theme_template ||= 'default' if options[:theme].present?
      super([options[:theme], theme_template, file].compact.join('/'))
    end
  end
end