require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah do
  before do
    @url = 'http://example.com'
    @url_200 = "#{@url}/200/Ok"
    @url_301 = "#{@url}/301/Redirect"
    @url_404 = "#{@url}/404/Not fould"
    
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
      @bw.get @url_200 do |response|
        assert_equal 200,  response.status_code
        assert_equal 'Ok', response.body
      end
    end

    it "simple using done to wait response" do
      @bw.get @url_200
      
      status_code = nil
      body = nil
      @bw.on_done do |response|
        status_code = response.status_code
        body = response.body
      end
      
      assert_equal 200, status_code
      assert_equal 'Ok', body
    end
    
    it "support multi urls in one request" do
      results = []
      @bw.get [@url_200, @url_404] do |responses|
        results << responses.first.status_code
        results << responses.last.status_code
      end
      assert_equal [200, 404], results
    end
    
    it "multi request" do
      @bw.get @url_200
      @bw.get @url_404
      
      results = []
      @bw.on_done do |r1, r2|
        results << r1.status_code
        results << r2.status_code
      end
      
      assert_equal [200, 404], results
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
