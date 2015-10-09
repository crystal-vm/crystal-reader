[ 3 + 4 , foo(22) ]
-- -- --
s(:array,
  s(:operator_value, :+,
    s(:int, 3),
    s(:int, 4)),
  s(:call,
    s(:name, :foo),
    s(:arguments,
      s(:int, 22))))
