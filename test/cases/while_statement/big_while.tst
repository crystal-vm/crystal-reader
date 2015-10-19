while_allgood( n > 1)
  tmp = a
  a = b
  b = tmp + b
  puts(b)
  n = n - 1
end
-- -- --
s(:while_statement, :allgood,
  s(:conditional,
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
        s(:int, 1)))))
