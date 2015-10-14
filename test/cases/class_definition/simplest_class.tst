class Foo
  field int x
end
-- -- --
s(:statements,
  s(:class, :Foo,
    s(:derives, nil),
    s(:statements,
      s(:class_field, :Integer, :x))))
