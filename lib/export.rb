require File.dirname(__FILE__) + '/../ext/callsite'

module Export
  def export_list
    @__exported__ ||= {}
  end
  
  def export(meth, *classes)
    meth = meth.to_s
    (export_list[meth] ||= []).push(*classes)
    alias_method "__exported__#{meth}", meth
    define_method(meth) do |*args, &block|
      cclass, classes = caller_class, self.class.export_list[meth]
      if classes && !classes.any? {|k| cclass >= k }
        raise NoMethodError, 
          "`#{meth}' is not accessible to #{cclass.inspect}:#{cclass.class.inspect}",
          caller
      end
      send("__exported__#{meth}", *args, &block)
    end
  end
end

(RUBY_VERSION >= "1.9.1" ? BasicObject : Object).send(:extend, Export)
