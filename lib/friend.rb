require File.dirname(__FILE__) + '/../ext/callsite'

module Friend
  def friend_list
    @__friends__ ||= {}
  end
  
  def friend(meth, *classes)
    meth, expmeth = meth.to_s, "__friends__#{meth}"
    (friend_list[meth] ||= []).push(*classes)
    alias_method expmeth, meth
    private expmeth
    public meth
    define_method(meth) do |*args, &block|
      cclass, classes = caller_class, self.class.friend_list[meth]
      if cclass == false
        raise NoMethodError, "`#{meth}' is not accessible outside #{self.class}"
      elsif cclass != self.class && classes && !classes.any? {|k| cclass <= k }
        raise NoMethodError, 
          "`#{meth}' is not accessible to #{cclass.inspect}:#{cclass.class.inspect}",
          caller
      end
      send(expmeth, *args, &block)
    end
  end
  
  alias export friend
end

(RUBY_VERSION >= "1.9.1" ? BasicObject : Object).send(:extend, Friend)
