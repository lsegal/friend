require "test/unit"
require File.dirname(__FILE__) + '/../lib/friend'

class EA; def bar; ED.new.foo end end
class EB; def bar; ED.new.foo end end
class EC; def bar; ED.new.foo end end
class EE < EB; def bar; ED.new.foo end end
class ED
  def foo; "foobar" end
  def bar; foo end
  export :foo, EA, EB
end

class TestCallsite < Test::Unit::TestCase
  def test_export_A
    assert_equal "foobar", EA.new.bar
  end

  def test_export_B
    assert_equal "foobar", EB.new.bar
  end

  def test_export_C
    assert_raises(NoMethodError) { EC.new.bar }
  end
  
  def test_export_E
    assert_equal "foobar", EE.new.bar
  end
  
  def test_local_call
    assert_equal "foobar", ED.new.bar
  end
end