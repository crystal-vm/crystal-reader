int foo(int x)
  int a = 5
  return a
end
-- -- --
s(:statements,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :int, :x)),
    s(:statements,
      s(:field_def, :int, :a,
        s(:int, 5)),
      s(:return,
        s(:name, :a)))))
