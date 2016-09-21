require "affiliate_window"
require "support/fake_client"

require "rspec"
require "pry"
require "vcr"
require "webmock"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.color = true
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
