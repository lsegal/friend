# Friend


Adds fine-grained visibility semantics to Ruby, allowing you to make methods
visible only to specific classes (and their subclasses).

## Installing

    $ [sudo] gem install friend
    
Or build it manually:

    $ git clone git://github.com/lsegal/friend
    $ cd friend
    $ rake install

## Using

To use the library, require it and call `friend` (aka. `export`) from
any module/class to export a method to a list of specific classes in the
form:

    export :methodname, Class1, Class2, ...
    
**Note**: `export` is an alias of `friend`. They do the exact same thing, though
depending on your semantics one terminology might be more suited than the
other.

## Example

    require 'friend'
    
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
    
More examples can be found in the `example/` directory.

## License & Author

Friend is written by Loren Segal &copy; 2010, licensed under the BSD license.
This software can be redistributed and modified so long as it maintains the
copyright notice and `LICENSE` file. See `LICENSE` for more information.
