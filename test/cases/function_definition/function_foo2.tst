int foo(int x)
  int a = 5
  return a
end
3.foo( 4 )
-- -- --
s(:expressions,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :int, :x)),
    s(:expressions,
      s(:field_def, :int, :a,
        s(:int, 5)),
      s(:return,
        s(:name, :a)))),
  s(:call,
    s(:name, :foo),
    s(:arguments,
      s(:int, 4)),
    s(:receiver,
      s(:int, 3))))
