require "spec_helper"

RSpec.describe AffiliateWindow::Parser do
  let(:response) { double(:response, body: body) }

  context "when the response contains pagination information" do
    let(:body) do
      {
        foo_response: {
          foo_return: "results",
          foo_count_return: "pagination",
        },
      }
    end

    it "returns a hash of the results and pagination information" do
      result = subject.parse(response, :foo)
      expect(result).to eq(results: "results", pagination: "pagination")
    end
  end

  context "when the response does not contain pagination information" do
    let(:body) do
      {
        foo_response: {
          foo_return: "results",
        },
      }
    end

    it "returns the value of the return key" do
      result = subject.parse(response, :foo)
      expect(result).to eq("results")
    end
  end

  describe "#parse_quota" do
    let(:response) { double(:response, header: { get_quota_response: "123" }) }

    it "parses the quota from the response header" do
      quota = subject.parse_quota(response)
      expect(quota).to eq(123)
    end
  end
end
