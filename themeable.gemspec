$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "themeable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "themeable"
  s.version     = Themeable::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "https://github.com/xiaohui-zhangxh/"
  s.summary     = "A tool for creating theme."
  s.description = "Creating theme, and puting into your Rails app"
  s.license     = "MIT"

  s.files = Dir["{bin,lib,templates}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.executables   = ["themeable"]
  s.add_dependency "rails", ">= 4.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
