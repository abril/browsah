# encoding: UTF-8

require 'em-synchrony/em-http'

class Browsah
  module Dsl
    def initialize(uri = '')
      @base_uri = uri.kind_of?(String) ? Addressable::URI.parse(uri) : uri
      @pull = []
    end
    
    def get(urls, *args, &block)
      request(:get, urls, *args, &block)
    end
    
    def post(urls, *args, &block)
      request(:post, urls, *args, &block)
    end
    
    def request(verb, urls, *args, &block)
      # Default options
      options = { :body => nil, :headers => {} }
      options.merge!(args.pop) if args.last.kind_of?(Hash)
      
      urls  = urls.kind_of?(Array) ? urls : [urls]
      urls += args
      
      @pull << urls.map { |url|
        request = Request.new(verb.to_sym, @base_uri, url, options)
      }
      on_done(&block) if block_given?
    end
    
    def on_done(&block)
      result = nil
      EM.synchrony do
        multi     = EM::Synchrony::Multi.new
        responses = []
        
        @pull.each do |requests|
          if (is_multi = requests.size > 1)
            responses << []
            index = responses.size - 1
          end
          
          requests.each do |request|
            http = EM::HttpRequest.new(request.uri.to_s).send(request.verb, {
              :body => request.body,
              :head => request.headers
            })
            http.callback {
              response = Response.new(self, http.response_header.status, {}, http.response)
              (is_multi ? responses[index] : responses) << response
            }
            multi.add request.uri.to_s.to_sym, http
          end
          
        end
        
        # Clean pull of request
        @pull = []
        
        multi.perform
        if block_given?
          responses << self if block.arity > responses.count
          result = (block.call(*responses))
        end
        EM.stop
      end
      result
    end
  end
end