# Load do ambiente da gem
require File.expand_path(File.dirname(__FILE__) + '/../lib/browsah.rb')

Bundler.require(:default, :test)
require 'minitest/pride'

begin
  require 'ruby-debug'
rescue Exception => e; end

class MiniTest::Spec
  include WebMock::API

  def setup
    WebMock.reset!
  end
end