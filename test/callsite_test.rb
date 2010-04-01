require "test/unit"
require File.dirname(__FILE__) + '/../ext/callsite'

class A; def foo; caller_class end end
class B; def bar; A.new.foo end end
module D; def zoo; define_method(:bar) {|*args, &block| A.new.foo } end end
class C; extend D; zoo end

class TestCallsite < Test::Unit::TestCase
  def test_callsite
    assert_equal B, B.new.bar
  end
  
  def test_callsite_from_define_method
    assert_equal C, C.new.bar
  end
end