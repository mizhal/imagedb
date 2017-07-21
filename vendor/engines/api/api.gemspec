$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "api"
  s.version     = Api::VERSION
  s.authors     = ["mizhal"]
  s.email       = ["mizhal@gmail.com"]
  s.homepage    = "http://github.com/mizhal"
  s.summary     = "Api for imagedb"
  s.description = "Api for imagedb"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"
end
