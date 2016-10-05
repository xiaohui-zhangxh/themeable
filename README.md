# Themeable

You can create theme with this tool, make your Rails app choose theme dynamically.

### Install gem

    gem i themeable

### Create my theme with command line

    themeable new famous

Now, directory `theme_famous` created with this tool.

### Design my theme

Start designing your theme in folder `theme`:

    ├── theme
    │   ├── assets
    │   │   └── famous
    │   │       ├── application.css
    │   │       ├── application.js
    │   │       └── vendor
    │   └── views
    │       └── layouts
    │           └── application.html.erb

### Use my theme in my Rails project

Add gem to Rails app:

    gem 'theme_famous', path: 'path_of_theme_famous'
    
Use theme in controller:

By default you need to remove `views/layouts/application.html.erb` from Rails app, make sure Rails can use theme's layout.

    class HomeController < ApplicationController
      acts_as_themeable 'famous'
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
        when 'famous' then 'famous'
        when 'classic' then 'classic'
        else; :none # :none means don't use theme
        end
      end
    end