baz(42, foo)
-- -- --
s(:call,
  s(:name, :baz),
  s(:arguments,
    s(:int, 42),
    s(:name, :foo)))
