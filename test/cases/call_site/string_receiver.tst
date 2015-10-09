"hello".puts()
-- -- --
s(:call,
  s(:name, :puts),
  s(:arguments),
  s(:receiver,
    s(:string, "hello")))
