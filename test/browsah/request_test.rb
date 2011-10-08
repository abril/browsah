require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah::Request do
  it "parse string to uri in initialize" do
    request = Browsah::Request.new('http://example.com:8080/path')
    assert_kind_of Addressable::URI, request.uri
    assert_equal 8080, request.uri.port
  end
  
  it "merge uri" do
    request = Browsah::Request.new('http://example.com', '/path')
    assert_equal "http://example.com/path", request.uri.to_s
  end
end