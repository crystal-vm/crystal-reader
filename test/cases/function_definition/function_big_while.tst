int fibonaccit(int n)
  a = 0
  b = 1
  while( n > 1 )
    tmp = a
    a = b
    b = tmp + b
    puts(b)
    n = n - 1
  end
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :fibonaccit),
    s(:parameters,
      s(:parameter, :Integer, :n)),
    s(:statements,
      s(:assignment,
        s(:name, :a),
        s(:int, 0)),
      s(:assignment,
        s(:name, :b),
        s(:int, 1)),
      s(:while_statement,
        s(:condition,
          s(:operator_value, :>,
            s(:name, :n),
            s(:int, 1))),
        s(:statements,
          s(:assignment,
            s(:name, :tmp),
            s(:name, :a)),
          s(:assignment,
            s(:name, :a),
            s(:name, :b)),
          s(:assignment,
            s(:name, :b),
            s(:operator_value, :+,
              s(:name, :tmp),
              s(:name, :b))),
          s(:call,
            s(:name, :puts),
            s(:arguments,
              s(:name, :b))),
          s(:assignment,
            s(:name, :n),
            s(:operator_value, :-,
              s(:name, :n),
              s(:int, 1))))))))
