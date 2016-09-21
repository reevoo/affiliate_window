class AffiliateWindow
  module ErrorHandler
    def self.handle(&block)
      begin
        block.call
      rescue Savon::Error => e
        raise Error, e.message
      end
    end
  end

  class Error < StandardError; end
end
