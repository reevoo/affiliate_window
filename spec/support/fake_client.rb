# This client returns a fake response containing its call arguments.
class AffiliateWindow
  class FakeClient
    def call(method, params, debug)
      root_key = :"#{method}_response"
      results_key = :"#{method}_return"
      quota_key = :get_quota_response

      body = {
        root_key => {
          results_key => params.merge(
            method: method,
          ),
        }
      }

      header = { quota_key => "1234" }

      Struct.new(:body, :header).new(body, header)
    end
  end
end
