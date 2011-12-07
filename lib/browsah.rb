# encoding: UTF-8
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__))

# Dependencies
require 'rubygems'
require 'em-synchrony'
require 'em-synchrony/em-http'

require File.dirname(__FILE__) + '/browsah/version'
require File.dirname(__FILE__) + '/browsah/helpers'
require File.dirname(__FILE__) + '/browsah/dsl'
require File.dirname(__FILE__) + '/browsah/response'
require File.dirname(__FILE__) + '/browsah/request'

class Browsah
  include Dsl
  # autoload :AClass , "migrator/a_class"
end
