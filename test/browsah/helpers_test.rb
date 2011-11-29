require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Browsah::Helpers do
  it "should normalize headers" do
    final = {
      'content-type' => 'application/json',
      'host'         => 'localhost'
    }
    
    assert_equal final, Browsah::Helpers.normalize_headers({
      'Content-Type' => 'application/json',
      'Host'         => 'localhost'
    })
  end
end
