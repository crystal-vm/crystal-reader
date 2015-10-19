if_true(0)
  fourty = 10
else
  twenty = 5
end
-- -- --
s(:if_statement, :true,
  s(:condition,
    s(:int, 0)),
  s(:true_statements,
    s(:assignment,
      s(:name, :fourty),
      s(:int, 10))),
  s(:false_statements,
    s(:assignment,
      s(:name, :twenty),
      s(:int, 5))))
