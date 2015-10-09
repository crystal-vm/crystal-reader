if(3 > var)
  Object.initialize(3)
else
  var.new(33)
end
-- -- --
s(:if_statement,
  s(:condition,
    s(:operator_value, :>,
      s(:int, 3),
      s(:name, :var))),
  s(:true_statements,
    s(:call,
      s(:name, :initialize),
      s(:arguments,
        s(:int, 3)),
      s(:receiver,
        s(:class_name, :Object)))),
  s(:false_statements,
    s(:call,
      s(:name, :new),
      s(:arguments,
        s(:int, 33)),
      s(:receiver,
        s(:name, :var)))))
