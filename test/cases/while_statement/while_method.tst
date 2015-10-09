while(1)
  tmp = String.new()
  tmp.puts(i)
end
-- -- --
s(:while_statement,
  s(:condition,
    s(:int, 1)),
  s(:statements,
    s(:assignment,
      s(:name, :tmp),
      s(:call,
        s(:name, :new),
        s(:arguments),
        s(:receiver,
          s(:class_name, :String)))),
    s(:call,
      s(:name, :puts),
      s(:arguments,
        s(:name, :i)),
      s(:receiver,
        s(:name, :tmp)))))
