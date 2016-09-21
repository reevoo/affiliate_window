require "./lib/affiliate_window/version"

Gem::Specification.new do |s|
  s.name        = "affiliate_window"
  s.version     = AffiliateWindow::VERSION
  s.summary     = "Affiliate Window: Publisher Service API"
  s.description = "A gem for communicating with Affiliate Window's Publisher Service API."
  s.author      = "Reevoo Developers"
  s.email       = "developers@reevoo.com"
  s.homepage    = "https://github.com/reevoo/affiliate_window"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]

  s.add_dependency "savon"

  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "rake"
end
