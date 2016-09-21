require "./lib/affiliate_window/version"

Gem::Specification.new do |s|
  s.name        = "affiliate_window"
  s.version     = AffiliateWindow::VERSION
  s.license     = "MIT"
  s.summary     = "Affiliate Window: Publisher Service API"
  s.description = "A gem for communicating with Affiliate Window's Publisher Service API."
  s.author      = "Reevoo Developers"
  s.email       = "developers@reevoo.com"
  s.homepage    = "https://github.com/reevoo/affiliate_window"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]

  s.add_dependency "savon", "~> 2.11"

  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "pry", "~> 0.10"
  s.add_development_dependency "vcr", "~> 3.0"
  s.add_development_dependency "webmock", "~> 2.1"
  s.add_development_dependency "rake", "~> 11.3"
end
