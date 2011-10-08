require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah do
  before do
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
    before do
      @bw  = Browsah.new
    end
    
    it "simple" do
      @bw.get @url + '/200/Ok' do |response|
        assert_equal 200,  response.status_code
        assert_equal 'Ok', response.body
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
      
      assert_equal 200, status_code
      assert_equal 'Ok', body
    end
    
    it "multi request" do
      @bw.get "#{@url}/200/Ok"
      @bw.get "#{@url}/404/Not found"
      
      result = []
      @bw.done do |r1, r2|
        result << r1.status_code
        result << r2.status_code
      end
      
      assert_equal [200, 404], result
    end
  end
  
  it "support host or short path in request" do
    bw = Browsah.new(@url)
    bw.get "/200/Oks" do |r|
      assert_equal 200, r.status_code
    end
    bw.get "#{@url}/301/Redirect" do |r|
      assert_equal 301, r.status_code
    end
  end
  
  # describe "rules" do
  #   it "simple rules" do
  #     @bw.rule 'http://'
  #   end
  # end
end
