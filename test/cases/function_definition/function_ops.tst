int foo(int x)
 int abba = 5
 abba = abba + 5
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :Integer, :x)),
    s(:statements,
      s(:field_def, :Integer, :abba,
        s(:int, 5)),
      s(:assignment,
        s(:name, :abba),
        s(:operator_value, :+,
          s(:name, :abba),
          s(:int, 5))))))
