module Themeable
  module GeneratorConcern
    def self.included(klass)
      klass.instance_eval do
        class_option :theme, type: :string, desc: "Choose theme to generate files", default: nil
        class_option :theme_scaffold, type: :string, desc: "Choose a templete to scaffold", default: nil
      end
    end

    # Support theme and template
    def find_in_source_paths(file)
      theme_scaffold = options[:theme_scaffold]
      theme_scaffold ||= 'default' if options[:theme].present?
      themed_file = [options[:theme], theme_scaffold, file].compact.join('/')
      super(themed_file)
    rescue Thor::Error => e
      if e.message =~ /^Could not find /
        say "Can't find themed file #{themed_file}, use default template", :yellow
        return super(file)
      else
        raise
      end
    end
  end
end