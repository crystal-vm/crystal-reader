5 % foo.bar
-- -- --
s(:operator_value, :%,
  s(:int, 5),
  s(:field_access,
    s(:receiver,
      s(:name, :foo)),
    s(:field,
      s(:name, :bar))))
