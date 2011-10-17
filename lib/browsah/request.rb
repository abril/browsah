class Browsah
  class Request
    attr_accessor :uri
    attr_reader :headers
    attr_reader :body
    
    def initialize(base_uri, uri = '', options = {})
      @headers = normalize_headers(options[:headers] || options['headers'] || {})
      base_uri = base_uri.kind_of?(String) ? Addressable::URI.parse(base_uri) : base_uri
      @uri = base_uri + (uri.kind_of?(String) ? Addressable::URI.parse(uri) : uri)
    end
    
  private
    
    def normalize_headers(headers)
      Hash[headers.map { |k, v| [k.downcase, v] }]
    end
  end
end