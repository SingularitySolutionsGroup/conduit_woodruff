module Pusher
  class Client
    alias :original_sync_http_client :sync_http_client
    def sync_http_client
      c = original_sync_http_client
      c.ssl_config.verify_mode = 0
      c
    end
  end
end

module PoxaAssist
  module RestApi
    def self.open url
      uri = URI.parse url
      http = Net::HTTP.new(uri.host, uri.port)
      if url.downcase.start_with? 'https'
        http.verify_mode = 0
        http.use_ssl = true
        end
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request request
      Struct.new(:read).new response.body
    end
  end
end
