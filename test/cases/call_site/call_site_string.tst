puts( "hello")
-- -- --
s(:call,
  s(:name, :puts),
  s(:arguments,
    s(:string, "hello")))
