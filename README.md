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
    └── views
        └── layouts
            └── application.html.erb

If you have some vendor scripts and stylesheets, please put them in vendor/my_theme:

    vendor
    └── my_theme

To require vendor files, do it as this:

# in some.js

    //= require my_theme/xxx/xxx

# in some.css

    *= require my_theme/xxx/xxx

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