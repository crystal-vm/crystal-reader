while_false(1)
  tmp = a
  puts(b)
end
-- -- --
s(:while_statement, :false,
  s(:conditional,
    s(:int, 1)),
  s(:statements,
    s(:assignment,
      s(:name, :tmp),
      s(:name, :a)),
    s(:call,
      s(:name, :puts),
      s(:arguments,
        s(:name, :b)))))
