require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah do
  before do
    @bw  = Browsah.new
    @url = 'http://example.com'
    stub_request(:get, /example.com.*/).
    to_return(lambda { |request|
      {
        :status => request.uri.path[1..3].to_i,
        :body => request.uri.path[5..-1]
      }
    })
  end
  
  describe "get" do
    it "simple" do
      @bw.get @url + '/200/Ok' do |response|
        assert_equal response.status_code, 200
        assert_equal response.body, 'Ok'
      end
    end

    it "simple using done to wait response" do
      @bw.get @url + '/200/Ok'
      
      status_code = nil
      body = nil
      @bw.done do |response|
        status_code = response.status_code
        body = response.body
      end
      
      assert_equal status_code, 200
      assert_equal body, 'Ok'
    end
    
    it "multi request" do
      @bw.get 'http://example.com/200/Ok'
      @bw.get 'http://example.com/404/Not found'
      
      result = []
      @bw.done do |r1, r2|
        result << r1.status_code
        result << r2.status_code
      end
      
      assert_equal result, [200, 404]
    end
  end
  
  describe "rules" do
    it "simple rules"
  end
end
