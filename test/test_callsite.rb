require "test/unit"
require File.dirname(__FILE__) + '/../ext/callsite'

class CA; def foo; caller_class end end
class CB; def bar; CA.new.foo end end
module CD; def zoo; define_method(:bar) {|*args, &block| CA.new.foo } end end
class CC; extend CD; zoo end

class TestCallsite < Test::Unit::TestCase
  def test_callsite
    assert_equal CB, CB.new.bar
  end
  
  def test_callsite_from_define_method
    assert_equal CC, CC.new.bar
  end
end