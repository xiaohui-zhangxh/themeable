require 'thor'
require 'active_support/core_ext/string'

module Themeable
  class Command < Thor
    include Thor::Actions
    source_root File.expand_path("../../../templates", __FILE__)

    desc "help [COMMAND]", "View Usage"
    def help(*args)
      super(*args)
    end

    desc "new THEME_NAME", "Create a new theme"
    def new(name)
      @theme_name = name
      @app_name = "theme_#{name}"
      say('Initializing theme project...', :green)
      # say("\"rails plugin new #{app_name} -T\"")
      system "rails plugin new #{app_name} -T"

      @destination_stack ||= []
      @destination_stack[0] = File.expand_path(app_name)

      gsub_file "#{app_name}.gemspec", /TODO[: ]*/, ''
      gsub_file "#{app_name}.gemspec", %r{^ *s\.files *=.*} do
        '  s.files = Dir["{lib,theme}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]'
      end

      insert_into_file "#{app_name}.gemspec", after: %r{^ *s\.add_dependency .*} do
        "\n  s.add_dependency 'themeable'"
      end

      # generators
      template 'theme_views_generator.rb', "lib/generators/themeable/#{theme_name}/views_generator.rb"
      template 'theme_assets_generator.rb', "lib/generators/themeable/#{theme_name}/assets_generator.rb"

      # assets and views
      create_file "theme/assets/#{theme_name}/application.css"
      create_file "theme/assets/#{theme_name}/application.js"
      create_file "theme/views/layouts/.gitkeep"
      template "view_application.html.erb", "theme/views/layouts/application.html.erb"

      # vender files
      create_file "vendor/#{theme_name}/.gitkeep"

      # libs
      remove_file "lib/#{app_name}.rb"
      template 'theme_main.rb', "lib/#{app_name}.rb"

      puts
      say("Done. Please check your new theme project in directory #{app_name}", :green)
      puts
    end

    no_tasks do
      def app_name
        @app_name
      end
      def theme_name
        @theme_name
      end
      def set_destination_root(name)
        destination_root = name
      end
    end
  end
end
