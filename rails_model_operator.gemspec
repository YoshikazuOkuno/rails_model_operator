$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails_model_operator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_model_operator"
  s.version     = RailsModelOperator::VERSION
  s.authors     = ["yamazaki164"]
  s.email       = ["yamazaki164@gmail.com"]
  s.homepage    = "https://github.com/YoshikazuOkuno/rails_model_operator"
  s.summary     = "Summary of RailsModelOperator."
  s.description = "Description of RailsModelOperator."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-rails"
end
