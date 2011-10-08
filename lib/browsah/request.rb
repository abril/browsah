class Browsah
  class Request
    attr_accessor :uri
    
    def initialize(base_uri, uri = '')
      base_uri = base_uri.kind_of?(String) ? Addressable::URI.parse(base_uri) : base_uri
      @uri = base_uri + (uri.kind_of?(String) ? Addressable::URI.parse(uri) : uri)
    end
  end
end