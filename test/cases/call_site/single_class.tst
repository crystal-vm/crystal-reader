Object.foo(42)
-- -- --
s(:call,
  s(:name, :foo),
  s(:arguments,
    s(:int, 42)),
  s(:receiver,
    s(:class_name, :Object)))
