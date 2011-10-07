$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__))

# Dependencies
require "rubygems"
require "bundler/setup"
# require other dependencies here...

require 'browsah/version'
require 'browsah/dsl'
require 'browsah/response'

class Browsah
  include Dsl
  # autoload :AClass , "migrator/a_class"
end
