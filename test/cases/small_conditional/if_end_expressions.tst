if_overflow(3 + 100000 )
  Object.initialize(3)
end
-- -- --
s(:if_statement, :overflow,
  s(:condition,
    s(:operator_value, :+,
      s(:int, 3),
      s(:int, 100000))),
  s(:true_statements,
    s(:call,
      s(:name, :initialize),
      s(:arguments,
        s(:int, 3)),
      s(:receiver,
        s(:class_name, :Object)))),
  s(:false_statements, nil))
