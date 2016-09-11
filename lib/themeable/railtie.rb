require 'rails'
module Themeable
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActionController::Base.send :include, Themeable::ActsAsThemeable
    end
  end
end
