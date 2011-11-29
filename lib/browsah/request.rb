class Browsah
  class Request
    attr_accessor :uri
    attr_reader :headers
    attr_reader :body
    attr_reader :method
    
    alias_method :type, :method
    
    def initialize(method, base_uri, path = '', options = {})
      (options, path) = [path, ''] if path.kind_of?(Hash)

      @method  = method
      @headers = Helpers.normalize_headers(options[:headers] || options['headers'] || {})
      @body    = (options[:body] || options['body'] || nil)
      
      base_uri = base_uri.kind_of?(String) ? Addressable::URI.parse(base_uri) : base_uri
      @uri = base_uri + (path.kind_of?(String) ? Addressable::URI.parse(path) : path)
    end
  end
end