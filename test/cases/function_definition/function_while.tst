Biggie fibonaccit(int n)
  a = 0
  while(n)
    some = 43
    other = some * 4
  end
end
-- -- --
s(:statements,
  s(:function, :Biggie,
    s(:name, :fibonaccit),
    s(:parameters,
      s(:parameter, :Integer, :n)),
    s(:statements,
      s(:assignment,
        s(:name, :a),
        s(:int, 0)),
      s(:while_statement,
        s(:condition,
          s(:name, :n)),
        s(:statements,
          s(:assignment,
            s(:name, :some),
            s(:int, 43)),
          s(:assignment,
            s(:name, :other),
            s(:operator_value, :*,
              s(:name, :some),
              s(:int, 4))))))))
