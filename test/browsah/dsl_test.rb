require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah do
  before do
    # @url = 'http://localhost:4567'
    @url = 'http://example.com'
    @url_200 = "#{@url}/200/Ok"
    @url_301 = "#{@url}/301/Redirect"
    @url_404 = "#{@url}/404/Notfould"
  end
  
  describe "requests" do
    it "should support a headers" do
      browsah_stub_request.with(
        :headers => { "Content-Type" => "application/json" }
      )
      bw = Browsah.new(@url)
      assert_equal 200, (bw.get "/200/Oks", :headers => { "Content-Type" => "application/json" }  { |r| r.status_code } )
    end

    it "support host or short path" do
      browsah_stub_request
      bw = Browsah.new(@url)
      assert_equal 200, (bw.get "/200/Oks" do |r| r.status_code end)
      assert_equal 301, (bw.get "#{@url}/301/Redirect" do |r| r.status_code end)
    end
    
    describe "support get" do
      before do
        @bw  = Browsah.new
        browsah_stub_request
      end

      it "simple" do
        response = @bw.get @url_200 do |response|
          response
        end
        assert_equal 200,  response.status_code
        assert_equal 'Ok', response.body
      end

      it "simple using done to wait response" do
        @bw.get @url_200
        result = @bw.on_done do |response|
          [response.status_code, response.body]
        end
        assert_equal [200, 'Ok'], result
      end

      it "should pass browsah to block" do
        result = @bw.get @url_200 do |response, browsah|
          browsah
        end
        assert_kind_of Browsah, result
      end

      it "support multi urls in one request" do
        assert_equal [200, 404], (@bw.get [@url_200, @url_404] do |responses|
          [responses.first.status_code, responses.last.status_code]
        end)
        assert_equal [200, 404], (@bw.get @url_200, @url_404 do |responses|
          [responses.first.status_code, responses.last.status_code]
        end)
      end

      it "multi request" do
        @bw.get @url_200
        @bw.get @url_404

        assert_equal [200, 404], (@bw.on_done do |r1, r2|
          [r1.status_code, r2.status_code]
        end)
      end
    end
    
    describe "support post" do
      before do
        @bw = Browsah.new(@url)
      end
      
      it "simple call" do
        browsah_stub_request(:post).with(
          :body => 'foo bar'
        )
        assert_equal 200, (@bw.post @url_200, :body => 'foo bar' do |response|
          response.status_code
        end)
      end
      
      it "form call" do
        browsah_stub_request(:post).with(
          :body => "text=foo%20bar"
        )
        assert_equal 200, (@bw.post @url_200, :body => { :text => "foo bar"} do |response|
          response.status_code
        end)
      end
    end
  end
  
  # Helpers
  def browsah_stub_request(method = :get, pattern = /example.com.*/, &block)
    proc = block_given? ? lambda(&block) : lambda do |request|
      path = path_extract(request.uri)
      { :status => path[1].to_i, :body => path[2] }
    end
    stub_request(method, pattern).to_return(proc)
  end
  
  def path_extract(uri)
    Addressable::URI.parse(uri).path.split("/")
  end
end
