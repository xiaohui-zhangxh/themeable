module Themeable
  module GeneratorConcern
    def self.included(klass)
      klass.instance_eval do
        class_option :theme, type: :string, desc: "Choose theme to generate files", default: nil
        class_option :theme_scaffold, type: :string, desc: "Choose a templete to scaffold", default: nil
      end
    end

    def resolve_themeable_value(key)
      return options[key] if options[key].present?
      if theme_scaffold_mapping.size > 0
        folders = name.split('/')
        folders.pop
        loop do
          break if folders.size == 0
          path = folders.join('/')
          v = theme_scaffold_mapping.fetch(path.intern) { theme_scaffold_mapping.fetch(path.to_s, nil) }
          vv = v && (v[key.intern] || v[key.to_s])
          return vv if vv.present?
          folders.pop
        end
      end
    end

    def theme_scaffold_mapping
      Rails.application.config.generators.theme_scaffold_mapping
    end

    # Support theme and template
    def find_in_source_paths(file)
      theme = resolve_themeable_value(:theme)
      theme_scaffold = resolve_themeable_value(:theme_scaffold)
      theme_scaffold ||= 'default' if theme
      themed_file = [theme, theme_scaffold, file].compact.join('/')
      super(themed_file)
    rescue Thor::Error => e
      if e.message =~ /^Could not find /
        say "Can't find themed file #{themed_file}, use default template", :yellow unless @behavior == :revoke
        return super(file)
      else
        raise
      end
    end
  end
end
