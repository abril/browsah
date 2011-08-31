require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*.rb']
  t.verbose = true
end

desc 'Load the gem environment'
task :environment do
  require File.expand_path(File.dirname(__FILE__) + '/lib/browsah.rb')
end

desc "Build the gem"
task :build do
  gem_name = 'browsah'
  opers = Dir.glob('*.gem')
  opers = ["rm #{ opers.join(' ') }"] unless opers.empty?
  opers << ["gem build #{gem_name}.gemspec"]
  sh opers.join(" && ")
end

desc "Build and install the gem, removing old installation"
task :install => :build do
  gem_file = Dir.glob('*.gem').first
  gem_name = 'browsah'
  if gem_file.nil?
    puts "could not install the gem"
  else
    sh "gem uninstall --ignore-dependencies --executables #{gem_name}; gem install #{ gem_file }"
  end
end

# To load rake tasks on lib/task folder
# load 'lib/tasks/task_sample.rake'

task :default => :test
