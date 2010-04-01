require 'mkmf'
$CPPFLAGS += " -DRUBY19" if RUBY_VERSION =~ /1.9/
create_makefile('callsite')
