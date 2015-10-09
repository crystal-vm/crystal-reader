class Object
  int foo(ref x)
    a = 5
  end
end
class Other < Object

  int foo()
    foo( 3 )
  end
end
-- -- --
s(:statements,
  s(:class, :Object,
    s(:derives, nil),
    s(:statements,
      s(:function, :int,
        s(:name, :foo),
        s(:parameters,
          s(:parameter, :ref, :x)),
        s(:statements,
          s(:assignment,
            s(:name, :a),
            s(:int, 5)))))),
  s(:class, :Other,
    s(:derives, :Object),
    s(:statements,
      s(:function, :int,
        s(:name, :foo),
        s(:parameters),
        s(:statements,
          s(:call,
            s(:name, :foo),
            s(:arguments,
              s(:int, 3))))))))
