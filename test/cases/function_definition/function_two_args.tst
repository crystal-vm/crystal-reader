int foo( int n ,ref  m)
  return n
end
-- -- --
s(:statements,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :int, :n),
      s(:parameter, :ref, :m)),
    s(:statements,
      s(:return,
        s(:name, :n)))))
