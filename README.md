## Affiliate Window

This gem lets you make requests to Affiliate Window's Publisher Service API.
At the time of writing, it is on version 6. The API is documented
[here](http://wiki.affiliatewindow.com/index.php/Publisher_Service_API).

There is [an existing gem](https://github.com/andyt/affiliate-window) for
communicating with Affiliate Window but it looks to be unsupported and doesn't
work with its Publisher Service API.

## Usage

```ruby
client = AffiliateWindow.login(
  account_id: 1234,
  affiliate_api_password: "your api key",
)

response = client.get_transaction_list(
  start_date: "2006-08-04T00:00:00",
  end_date: "2006-08-14T23:59:59",
  date_type: "transaction",
)

response.dig(:results, :transaction, 0)
#=> {
#  i_id: "1",
#  s_status: "confirmed",
#  b_paid: true,
#  m_sale_amount: {
#    d_amount: "50.00",
#    s_currency: "GBP"
#  },
#  ...
```

The gem follows the convention that all API methods are called by their
snake case name. Parameter names mirror the API, for example:

```
iMerchantId -> merchant_id
aTransactionIds -> transaction_ids
aStatus -> status
```

If the endpoint returns metadata about how many records were returned, this is
returned in the `pagination` key of the output, e.g.

```ruby
response
#=> {
#  pagination: {
#    i_rows_returned: "10",
#    i_rows_available: "50"
#  }
```

## Quota

The API provides a daily quota of 15,000 requests per account. The remaining
quota is returned in the header of each response. If this quota is reached,
subsequent requests to the API will raise errors.

You can check the remaining quota with:

```ruby
client.remaining_quota
#=> 14997
```

## Debugging

You can print the SOAP request bodies by enabling debug mode:

```ruby
client.debug = true
client.get_merchant_list
# <?xml version='1.0' encoding='UTF-8'?>
# ...
```
