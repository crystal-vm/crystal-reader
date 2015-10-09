int foo(int x)
 int abba = 5
 abba = abba + 5
end
-- -- --
s(:statements,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :int, :x)),
    s(:statements,
      s(:field_def, :int, :abba,
        s(:int, 5)),
      s(:assignment,
        s(:name, :abba),
        s(:operator_value, :+,
          s(:name, :abba),
          s(:int, 5))))))
