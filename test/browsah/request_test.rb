require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah::Request do
  describe "implement properties" do
    describe "uri" do
      it "parse string to uri in initialize" do
        request = Browsah::Request.new(:get, 'http://example.com:8080/path')
        assert_kind_of Addressable::URI, request.uri
        assert_equal 8080, request.uri.port
      end

      it "merge uri" do
        request = Browsah::Request.new(:get, 'http://example.com', '/path')
        assert_equal "http://example.com/path", request.uri.to_s
      end
    end
    
    describe "method" do
      it "should support method in initializer" do
        request = Browsah::Request.new(:get, 'http://example.com')
        assert_equal :get, request.method
      end
      
      it "should provide alias 'type' to method" do
        request = Browsah::Request.new(:get, 'http://example.com')
        assert_equal :get, request.type
      end
    end
    
    describe "body" do
      it "should return blank for default" do
        request = Browsah::Request.new(:get, 'http://example.com')
        assert_equal nil, request.body
      end
      
      it "should support the passage in initialize" do
        request = Browsah::Request.new(:get, 'http://example.com', { :body => 'Body text' })
        assert_equal 'Body text', request.body
      end
    end
    
    describe "headers" do
      before do
        @headers = { "content-type" => "text/html" }
      end

      it "should return blank for default" do
        request = Browsah::Request.new(:get, 'http://example.com', '/path')
        assert_equal({}, request.headers)
      end

      it "should support the passage in initialize" do
        request = Browsah::Request.new(:get, 'http://example.com', { :headers => @headers })
        assert_equal(@headers, request.headers)
      end

      it "should normalize" do
        headers = { "Content-Type" => "text/html" }
        request = Browsah::Request.new(:get, 'http://example.com', '/path', { :headers => headers })
        assert_equal(@headers, request.headers)
      end
    end
  end
end