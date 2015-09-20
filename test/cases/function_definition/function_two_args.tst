int foo( int n ,ref  m)
  n
end
-- -- --
s(:expressions,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :int, :n),
      s(:parameter, :ref, :m)),
    s(:expressions,
      s(:name, :n))))
