require "test/unit"
require File.dirname(__FILE__) + '/../lib/export'

class A; def bar; D.new.foo end end
class B; def bar; D.new.foo end end
class C; def bar; D.new.foo end end
class D
  def foo; "foobar" end 
  export :foo, A, B
end

class TestCallsite < Test::Unit::TestCase
  def test_export_A
    assert_equal "foobar", A.new.bar
  end

  def test_export_B
    assert_equal "foobar", B.new.bar
  end

  def test_export_C
    assert_raises(NoMethodError) { C.new.bar }
  end
end