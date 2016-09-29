require "spec_helper"

RSpec.describe AffiliateWindow do
  let(:client) do
    described_class.login(account_id: 1234, affiliate_api_password: password)
  end

  context "with valid credentials" do
    let(:password) { "valid password" }

    around do |example|
      VCR.use_cassette("valid_credentials") { example.run }
    end

    it "successfully makes requests to the Publisher Service API" do
      response = client.get_transaction_list(
        start_date: "2015-12-25T12:00:00",
        end_date: "2015-12-26T12:00:00",
        date_type: "transaction",
        limit: 2,
        offset: 20,
      )

      expect(response).to have_key(:results)
      expect(response).to have_key(:pagination)

      results = response.dig(:results, :transaction)
      pagination = response.fetch(:pagination)

      expect(results.first).to include(
        s_status: "declined",
        s_declined_reason: "Failed To Collect",
        s_type: "normal",
        b_paid: false,
        m_sale_amount: {
          d_amount: "415.83",
          s_currency: "GBP",
        },
        m_commission_amount: {
          d_amount: "12.47",
          s_currency: "GBP",
        }
      )

      expect(pagination).to eq(
        i_rows_available: "101",
        i_rows_returned: "2",
      )
    end

    it "tracks the quota after making a request" do
      expect {
        client.remaining_quota
      }.to raise_error(described_class::UnknownQuotaError)

      client.get_transaction_list(
        start_date: "2015-12-25T12:00:00",
        end_date: "2015-12-26T12:00:00",
        date_type: "transaction",
        limit: 2,
        offset: 20,
      )

      expect(client.remaining_quota).to eq 13154
    end
  end

  context "with invalid credentials" do
    let(:password) { "wrong password" }

    around do |example|
      VCR.use_cassette("invalid_credentials") { example.run }
    end

    it "raises an auth error" do
      expect {
        client.get_merchant_list
      }.to raise_error(described_class::Error, /Authentication Failed/)
    end

    it "provides support for debugging" do
      client.debug = true

      expect {
        client.get_merchant_list rescue nil
      }.to output(/xml version='1.0'/).to_stdout
    end
  end
end
