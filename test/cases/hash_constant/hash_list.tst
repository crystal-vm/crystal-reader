{foo => 33 , bar => 42}
-- -- --
s(:hash,
  s(:assoc,
    s(:name, :foo),
    s(:int, 33)),
  s(:assoc,
    s(:name, :bar),
    s(:int, 42)))
