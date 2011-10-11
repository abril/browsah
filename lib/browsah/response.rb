class Browsah
  class Response
    attr_reader :browsah
    attr_reader :status_code
    attr_reader :headers
    attr_reader :body
    
    def initialize(browsah, status_code, headers = {}, body = nil)
      @browsah     = browsah
      @status_code = status_code
      @headers     = {}
      @body        = body
    end
    
    def on(*args)
      if block_given? and
         args.any? { |i| i.kind_of?(Range) ? i.include?(status_code) : i == status_code }
        yield
      end
    end
    
    def method_missing(method, *args, &block)
      if block_given? && !(code = /on_([0-9]*)/.match(method)).nil?
        self.on(code[1].to_i, &block)
      else
        super(method, *args, &block)
      end
    end
  end
end