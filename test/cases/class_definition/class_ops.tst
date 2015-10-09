class Opers
  int foo(int x)
    int abba = 5
    return abba + 5
  end
end
-- -- --
s(:statements,
  s(:class, :Opers,
    s(:derives, nil),
    s(:statements,
      s(:function, :int,
        s(:name, :foo),
        s(:parameters,
          s(:parameter, :int, :x)),
        s(:statements,
          s(:field_def, :int, :abba,
            s(:int, 5)),
          s(:return,
            s(:operator_value, :+,
              s(:name, :abba),
              s(:int, 5))))))))
