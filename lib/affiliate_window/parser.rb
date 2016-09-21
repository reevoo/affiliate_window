class AffiliateWindow
  module Parser
    def self.parse(response, method)
      body = response.body
      root = body.fetch(:"#{method}_response")

      results = root.fetch(:"#{method}_return")
      pagination = root.fetch(:"#{method}_count_return", nil)

      if pagination
        { pagination: pagination, results: results }
      else
        results
      end
    end
  end
end
