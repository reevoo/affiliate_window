# For full API documentation, refer to:
# http://wiki.affiliatewindow.com/index.php/Publisher_Service_API

class AffiliateWindow
  attr_accessor :client, :error_handler, :parser, :debug, :remaining_quota

  def self.login(account_id:, affiliate_api_password:)
    client = Client.new(
      account_id: account_id,
      affiliate_api_password: affiliate_api_password,
    )

    new(client: client)
  end

  def initialize(client:, error_handler: ErrorHandler, parser: Parser)
    self.client = client
    self.error_handler = error_handler
    self.parser = parser
  end

  # Gets the commission values for a given commission group and advertiser
  # http://wiki.affiliatewindow.com/index.php/AS:getCommissionGroup
  def get_commission_group(merchant_id:, commission_group_code:)
    call(
      :get_commission_group,
      iMerchantId: merchant_id,
      sCommissionGroupCode: commission_group_code,
    )
  end

  # Gets an array of commission groups for an advertiser
  # http://wiki.affiliatewindow.com/index.php/AS:getCommissionGroupList
  def get_commission_group_list(merchant_id:)
    call(:get_commission_group_list, iMerchantId: merchant_id)
  end

  # Gets products for the specified transaction # http://wiki.affiliatewindow.com/index.php/AS:getTransactionProduct
  def get_transaction_product(transaction_ids:)
    call(:get_transaction_product, aTransactionIds: transaction_ids)
  end

  # Gets the transactions that fall under the specified criteria
  # http://wiki.affiliatewindow.com/index.php/AS:getTransactionList
  def get_transaction_list(merchant_ids: nil, start_date:, end_date:, date_type:, transaction_status: nil, limit: nil, offset: nil)
    call(
      :get_transaction_list,
      aMerchantIds: merchant_ids,
      dStartDate: start_date,
      dEndDate: end_date,
      sDateType: date_type,
      sTransactionStatus: transaction_status,
      iLimit: limit,
      iOffset: offset,
    )
  end

  # Gets the requested transactions
  # http://wiki.affiliatewindow.com/index.php/AS:getTransaction
  def get_transaction(transaction_ids:)
    call(:get_transaction, aTransactionIds: transaction_ids)
  end

  # Gets the requested advertisers
  # http://wiki.affiliatewindow.com/index.php/AS:getMerchant
  def get_merchant(merchant_ids:)
    call(:get_merchant, aMerchantIds: merchant_ids)
  end

  # Gets the advertisers that fall under the specified criteria
  # http://wiki.affiliatewindow.com/index.php/AS:getMerchantList
  def get_merchant_list(relationship: nil)
    call(:get_merchant_list, sRelationship: relationship)
  end

  # Gets the requested transaction queries
  # http://wiki.affiliatewindow.com/index.php/AS:getTransactionQuerys
  def get_transaction_queries(merchant_ids: nil, status: nil, click_refs:, offset: nil, limit: nil)
    call(
      :get_transaction_queries,
      aMerchantIds: merchant_ids,
      aStatus: status,
      aClickRefs: click_refs,
      iOffset: offset,
      iLimit: limit,
    )
  end

  # Gets the requested link click stats
  # http://wiki.affiliatewindow.com/index.php/AS:getClickStats
  def get_click_stats(start_date:, end_date:, merchant_ids: nil, date_type:, offset: nil, limit: nil)
    call(
      :get_click_stats,
      dStartDate: start_date,
      dEndDate: end_date,
      aMerchantIds: merchant_ids,
      sDateType: date_type,
      iOffset: offset,
      iLimit: limit,
    )
  end

  # Gets the requested link impression stats
  # http://wiki.affiliatewindow.com/index.php/AS:getImpressionStats
  def get_impression_stats(start_date:, end_date:, merchant_ids: nil, date_type:, offset: nil, limit: nil)
    call(
      :get_impression_stats,
      dStartDate: start_date,
      dEndDate: end_date,
      aMerchantIds: merchant_ids,
      sDateType: date_type,
      iOffset: offset,
      iLimit: limit,
    )
  end

  def remaining_quota
    @remaining_quota || raise(UnknownQuotaError,
      "No requests have been made, so the remaining quota is unknown."
    )
  end

  private

  def call(method, params)
    params = remove_nils(params)

    response = error_handler.handle do
      client.call(method, params, debug)
    end

    self.remaining_quota = parser.parse_quota(response)

    parser.parse(response, method)
  end

  def remove_nils(params)
    params.reject { |_, value| value.nil? }
  end

  class UnknownQuotaError < StandardError; end
end
