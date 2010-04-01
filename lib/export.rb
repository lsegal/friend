require File.dirname(__FILE__) + '/../ext/callsite'

module Export
  def export_list
    @__exported__ ||= {}
  end
  
  def export(meth, *classes)
    meth, expmeth = meth.to_s, "__exported__#{meth}"
    (export_list[meth] ||= []).push(*classes)
    alias_method expmeth, meth
    private expmeth
    public meth
    define_method(meth) do |*args, &block|
      cclass, classes = caller_class, self.class.export_list[meth]
      if cclass == false
        raise NoMethodError, "`#{meth}' is not accessible outside #{self.class}"
      elsif cclass != self.class && classes && !classes.any? {|k| cclass <= k }
        raise NoMethodError, 
          "`#{meth}' is not accessible to #{cclass.inspect}:#{cclass.class.inspect}",
          caller
      end
      send("__exported__#{meth}", *args, &block)
    end
  end
  
  alias friend export
end

(RUBY_VERSION >= "1.9.1" ? BasicObject : Object).send(:extend, Export)
