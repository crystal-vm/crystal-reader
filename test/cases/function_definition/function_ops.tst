int foo(int x)
 int abba = 5
 abba + 5
end
-- -- --
s(:expressions,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :int, :x)),
    s(:expressions,
      s(:field_def, :int, :abba,
        s(:int, 5)),
      s(:operator, "+",
        s(:name, :abba),
        s(:int, 5)))))
