gumbar & foo.bar
-- -- --
s(:operator_value, :&,
  s(:name, :gumbar),
  s(:field_access,
    s(:receiver,
      s(:name, :foo)),
    s(:field,
      s(:name, :bar))))
