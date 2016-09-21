require "spec_helper"

RSpec.describe AffiliateWindow::ErrorHandler do
  it "rescues Savon::Error and re-raises as an AffiliateWindow::Error" do
    expect {
      subject.handle { raise Savon::Error, "message" }
    }.to raise_error(AffiliateWindow::Error, "message")
  end

  it "does not affect any other error types" do
    expect {
      subject.handle { raise StandardError, "message" }
    }.to raise_error(StandardError, "message")
  end
end
