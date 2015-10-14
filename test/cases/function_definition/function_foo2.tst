int foo(int x)
  int a = 5
  return a
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :Integer, :x)),
    s(:statements,
      s(:field_def, :Integer, :a,
        s(:int, 5)),
      s(:return,
        s(:name, :a)))))
