require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah::Response do
  before do
    @brw = Browsah.new 
  end
  
  it "implement property to access a original browsah" do
    res = Browsah::Response.new(@brw, 404)
    assert_equal @brw, res.browsah
  end
  
  describe "implements facility 'on' to compare status code result" do
    it "should bear simple code" do
      response = Browsah::Response.new(@brw, 200)
      assert_nil response.on(400) { true }
      assert response.on(200) { true }
    end
    
    it "should bear a range of codes" do
      response = Browsah::Response.new(@brw, 200)
      assert response.on(100..300) { true }
    end
    
    it "should bear a multiples options, range or code" do
      [200, 300, 301, 404].each do |code|
        response = Browsah::Response.new(@brw, code)
        assert_equal code, response.on(200, 300..301, 404) { code }
      end
    end
    
    it "should support sugar syntax" do
      response = Browsah::Response.new(@brw, 200)
      assert response.on_200 { true }
    end
  end
end