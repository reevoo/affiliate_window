class AffiliateWindow
  class Client
    def initialize(account_id:, affiliate_api_password:)
      self.savon_client = Savon.client(
        wsdl: "http://api.affiliatewindow.com/v6/AffiliateService?wsdl",
        namespace: "http://api.affiliatewindow.com/",
        soap_header: {
          "api:UserAuthentication" => {
            "api:iId" => account_id.to_s,
            "api:sPassword" => affiliate_api_password,
            "api:sType" => "affiliate",
          },
          "api:getQuota" => true,
        },
      )
    end

    def call(method, params, debug = false)
      params = convert_to_soap_arrays(params)

      print_request(method, params) if debug
      savon_client.call(method, message: params)
    end

    def print_request(method, params)
      request = savon_client.build_request(method, message: params)
      document = REXML::Document.new(request.body)

      formatter = REXML::Formatters::Pretty.new
      formatter.write(document, $stdout)
    end

    private

    def convert_to_soap_arrays(params)
      params.each.with_object({}) do |(key, value), hash|
        value = value.is_a?(Array) ? { int: value } : value
        hash.merge!(key => value)
      end
    end

    attr_accessor :savon_client
  end
end
