require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

WINDOWS = (PLATFORM =~ /win32|cygwin/ ? true : false) rescue false
SUDO = WINDOWS ? '' : 'sudo'

task :default => :test
task :test => :build

Rake::TestTask.new

task :package => :build do
  sh "gem build friend.gemspec"
end

desc "Install the gem locally"
task :install => :package do 
  sh "#{SUDO} gem install pkg/#{SPEC.name}-#{SPEC.version}.gem --local"
  sh "rm -rf pkg/#{SPEC.name}-#{SPEC.version}" unless ENV['KEEP_FILES']
end

desc 'Build'
task :build do
  sh "cd ext && make"
end
