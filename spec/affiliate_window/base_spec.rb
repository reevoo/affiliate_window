require "spec_helper"

RSpec.describe AffiliateWindow do
  subject do
    AffiliateWindow.new(client: described_class::FakeClient.new)
  end

  describe "#get_commission_group" do
    it "returns results" do
      response = subject.get_commission_group(
        merchant_id: "merchant_id",
        commission_group_code: "commission_group_code",
      )

      expect(response).to eq(
        method: :get_commission_group,
        iMerchantId: "merchant_id",
        sCommissionGroupCode: "commission_group_code",
      )
    end
  end

  describe "#get_commission_group_list" do
    it "returns results" do
      response = subject.get_commission_group_list(
        merchant_id: "merchant_id",
      )

      expect(response).to eq(
        method: :get_commission_group_list,
        iMerchantId: "merchant_id",
      )
    end
  end

  describe "#get_transaction_product" do
    it "returns results" do
      response = subject.get_transaction_product(
        transaction_ids: "transaction_ids",
      )

      expect(response).to eq(
        method: :get_transaction_product,
        aTransactionIds: "transaction_ids",
      )
    end
  end

  describe "#get_transaction_list" do
    it "returns results" do
      response = subject.get_transaction_list(
        merchant_ids: "merchant_ids",
        start_date: "start_date",
        end_date: "end_date",
        date_type: "date_type",
        transaction_status: "transaction_status",
        limit: "limit",
        offset: "offset",
      )

      expect(response).to eq(
        method: :get_transaction_list,
        aMerchantIds: "merchant_ids",
        dStartDate: "start_date",
        dEndDate: "end_date",
        sDateType: "date_type",
        sTransactionStatus: "transaction_status",
        iLimit: "limit",
        iOffset: "offset",
      )
    end
  end

  describe "#get_transaction" do
    it "returns results" do
      response = subject.get_transaction(
        transaction_ids: "transaction_ids",
      )

      expect(response).to eq(
        method: :get_transaction,
        aTransactionIds: "transaction_ids",
      )
    end
  end

  describe "#get_merchant" do
    it "returns results" do
      response = subject.get_merchant(
        merchant_ids: "merchant_ids",
      )

      expect(response).to eq(
        method: :get_merchant,
        aMerchantIds: "merchant_ids",
      )
    end
  end

  describe "#get_merchant_list" do
    it "returns results" do
      response = subject.get_merchant_list(
        relationship: "relationship",
      )

      expect(response).to eq(
        method: :get_merchant_list,
        sRelationship: "relationship",
      )
    end
  end

  describe "#get_transaction_queries" do
    it "returns results" do
      response = subject.get_transaction_queries(
        merchant_ids: "merchant_ids",
        status: "status",
        click_refs: "click_refs",
        offset: "offset",
        limit: "limit",
      )

      expect(response).to eq(
        method: :get_transaction_queries,
        aMerchantIds: "merchant_ids",
        aStatus: "status",
        aClickRefs: "click_refs",
        iOffset: "offset",
        iLimit: "limit",
      )
    end
  end

  describe "#get_click_stats" do
    it "returns results" do
      response = subject.get_click_stats(
        start_date: "start_date",
        end_date: "end_date",
        merchant_ids: "merchant_ids",
        date_type: "date_type",
        offset: "offset",
        limit: "limit",
      )

      expect(response).to eq(
        method: :get_click_stats,
        dStartDate: "start_date",
        dEndDate: "end_date",
        aMerchantIds: "merchant_ids",
        sDateType: "date_type",
        iOffset: "offset",
        iLimit: "limit",
      )
    end
  end

  describe "#get_impression_stats" do
    it "returns results" do
      response = subject.get_impression_stats(
        start_date: "start_date",
        end_date: "end_date",
        merchant_ids: "merchant_ids",
        date_type: "date_type",
        offset: "offset",
        limit: "limit",
      )

      expect(response).to eq(
        method: :get_impression_stats,
        dStartDate: "start_date",
        dEndDate: "end_date",
        aMerchantIds: "merchant_ids",
        sDateType: "date_type",
        iOffset: "offset",
        iLimit: "limit",
      )
    end
  end
end
