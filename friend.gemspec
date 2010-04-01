SPEC = Gem::Specification.new do |s|
  s.name = "friend"
  s.version = "0.1.0"
  s.date = "2010-04-01"
  s.author = "Loren Segal"
  s.email = "lsegal@soen.ca"
  s.homepage = "http://github.com/lsegal/friend"
  s.summary = "Friend adds fine grained visibility semantics to Ruby"
  s.files = Dir["{ext,lib,example,test}/**/*"] + ['LICENSE', 'README.md', 'Rakefile'] - ['ext/friend.bundle', 'ext/Makefile', 'ext/friend.o']
  s.test_files = Dir['test/test_*.rb']
  s.require_paths = ['ext']
  s.extensions    = ['ext/extconf.rb']
end