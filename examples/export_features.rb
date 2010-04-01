require File.dirname(__FILE__) + '/../lib/friend'

class A; def bar; D.new.foo end end
class B; def bar; D.new.foo end end
class C; def bar; D.new.foo end end

class D
  def foo; "HELLO WORLD!" end
  
  # Export to A and B, but not C
  export :foo, A, B 
end

puts A.new.bar
puts B.new.bar
puts C.new.bar

# Output:
# 
# HELLO WORLD!
# HELLO WORLD!
# export_features.rb:5:in `bar': `foo' is not accessible to C:Class (NoMethodError)
#   from export_features.rb.rb:16:in `<main>'
