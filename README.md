# Themeable

You can create theme with this tool, make your Rails app choose theme dynamically.

### Install gem

    gem i themeable

### Create your theme with command line

    themeable new my_theme

Now, directory `theme_my_theme` created with this tool.

### Design your theme

Start designing your theme in folder `theme`:

    theme
    ├── assets
    │   └── my_theme
    │       ├── application.css
    │       └── application.js
    ├── scaffold_templates
    │   ├── admin
    │   │   ├── _form.html.erb
    │   │   ├── edit.html.erb
    │   │   ├── index.html.erb
    │   │   ├── new.html.erb
    │   │   └── show.html.erb
    │   └── default
    │       ├── _form.html.erb
    │       ├── edit.html.erb
    │       ├── index.html.erb
    │       ├── new.html.erb
    │       └── show.html.erb
    └── views
        └── layouts
            └── application.html.erb

- theme/assets/my_theme: where your stylesheets and javascripts should put in
- theme/scaffold_templates/xxx: your scaffold templates, generated default and admin by default, of course you can add more if you want
- theme/views: your views


If you have some vendor scripts and stylesheets, please put them in vendor/my_theme:

    vendor
    └── my_theme

To require vendor files, do it as this:

# in some.js

    //= require my_theme/xxx/xxx

# in some.css

    *= require my_theme/xxx/xxx



To resolve vendor files relative asset path, you should do like this:

    rake resolve:css_path

Some vendor files have relative urls in the CSS files for imports, images, etc. Rails prefers using helper methods for linking to assets within CSS. Relative paths can cause issues when assets are precompiled for production.

### Use your theme in your Rails project

Add gem to Rails app:

    gem 'theme_my_theme', path: 'path_of_theme_my_theme'
    
Use theme in controller:

By default you need to remove `views/layouts/application.html.erb` from Rails app, make sure Rails can use theme's layout.

    class HomeController < ApplicationController
      acts_as_themeable 'my_theme'
      def index
      end
    end

Or, you can make this controller use dynamic themes:

    class HomeController < ApplicationController
      acts_as_themeable :choose_theme
      def index
      end
      
      private
      
      def choose_theme
        case params[:theme]
        when 'my_theme' then 'my_theme'
        when 'classic' then 'classic'
        else; :none # :none means don't use theme
        end
      end
    end

### Use `theme_my_theme` as theme to scaffold controller views

    $ rails g scaffold_controller User --theme=my_theme
      
        create  app/controllers/users_controller.rb
        invoke  erb
        create    app/views/users
        create    app/views/users/index.html.erb
        create    app/views/users/edit.html.erb
        create    app/views/users/show.html.erb
        create    app/views/users/new.html.erb
        create    app/views/users/_form.html.erb
        invoke  test_unit
        create    test/controllers/users_controller_test.rb
        invoke  helper
        create    app/helpers/users_helper.rb
        invoke    test_unit
        invoke  jbuilder
        create    app/views/users/index.json.jbuilder
        create    app/views/users/show.json.jbuilder
        create    app/views/users/_user.json.jbuilder

### Choose scaffold template of theme

There are two templates automatically generated: default and admin

To choose default template, run:

`rails g scaffold_controller User --theme=my_theme --theme-scaffold=default`

To choose admin template, run:

`rails g scaffold_controller User --theme=my_theme --theme-scaffold=admin`

`--theme-scaffold=default` is default value if `--theme-scaffold` is not provided


### Customize `theme_my_theme` in your Rails project

In your Rails project, if you feel `theme_my_theme` is not perfect, and want to make some changes to it only affect current Rails project, instead of all Rails projects which are using gem `theme_my_theme`, now you can do this:

    $ rails g theme_my_theme:copy_assets
    
         exist  app/assets/themes
        create  app/assets/themes/my_theme/application.css
        create  app/assets/themes/my_theme/application.js
        
    $ rails g theme_my_theme:copy_views
        create  app/themes/my_theme
        create  app/themes/my_theme/layouts/.gitkeep
        create  app/themes/my_theme/layouts/application.html.erb
        create  lib/templates/erb/scaffold/my_theme/admin/_form.html.erb
        create  lib/templates/erb/scaffold/my_theme/admin/edit.html.erb
        create  lib/templates/erb/scaffold/my_theme/admin/index.html.erb
        create  lib/templates/erb/scaffold/my_theme/admin/new.html.erb
        create  lib/templates/erb/scaffold/my_theme/admin/show.html.erb
        create  lib/templates/erb/scaffold/my_theme/default/_form.html.erb
        create  lib/templates/erb/scaffold/my_theme/default/edit.html.erb
        create  lib/templates/erb/scaffold/my_theme/default/index.html.erb
        create  lib/templates/erb/scaffold/my_theme/default/new.html.erb
        create  lib/templates/erb/scaffold/my_theme/default/show.html.erb

### Set `theme_my_theme` as default theme

If you feel each time to generate scaffold controller has to provide `--theme=my_theme` is annoying, now you can set a default value like this:

in config/application.rb, add `config.generators.theme = :my_theme`

    module TestTheme
      class Application < Rails::Application

        ....

        config.generators.theme = :my_theme

        ...

      end
    end




    

