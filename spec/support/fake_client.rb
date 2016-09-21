# This client returns a fake response containing its call arguments.
class AffiliateWindow
  class FakeClient
    def call(method, params, debug)
      root_key = :"#{method}_response"
      results_key = :"#{method}_return"

      Struct.new(:body).new(
        root_key => {
          results_key => params.merge(
            method: method,
          ),
        }
      )
    end
  end
end
