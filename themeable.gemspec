$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "themeable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "themeable"
  s.version     = Themeable::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "http://tanmer.com"
  s.summary     = "Summary of Themeable."
  s.description = "Description of Themeable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.7.1"
  s.add_dependency "sass-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
