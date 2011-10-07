require 'em-synchrony/em-http'

class Browsah
  module Dsl
    def initialize
      @pull = []
    end
    
    def get(urls, &block)
      @pull << urls
      done(&block) if block_given?
    end
    
    def rule
    end
    
    def on
    end
    
    def done(&block)
      EM.synchrony do
        multi     = EM::Synchrony::Multi.new
        responses = []
        
        @pull.each do |request|
          http = EM::HttpRequest.new(request).aget
          http.callback {
            response = Response.new
            response.status_code = http.response_header.status
            response.body        = http.response
            responses << response
          }
          multi.add request.to_sym, http
        end
        
        multi.perform
        block.call(*responses) if block_given?
        EM.stop
      end
    end
  end
end