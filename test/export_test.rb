require "test/unit"
require File.dirname(__FILE__) + '/../lib/export'

class A; def bar; D.new.foo end end
class B; def bar; D.new.foo end end
class C; def bar; D.new.foo end end
class E < B; def bar; D.new.foo end end
class D
  def foo; "foobar" end
  def bar; foo end
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
  
  def test_export_E
    assert_equal "foobar", E.new.bar
  end
  
  def test_local_call
    assert_equal "foobar", D.new.bar
  end
end