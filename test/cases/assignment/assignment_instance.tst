self.a = 5
-- -- --
s(:assignment,
  s(:field_access,
    s(:receiver,
      s(:name, :self)),
    s(:field,
      s(:name, :a))),
  s(:int, 5))
