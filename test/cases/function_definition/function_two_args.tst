int foo( int n ,String  m)
  return n
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :Integer, :n),
      s(:parameter, :String, :m)),
    s(:statements,
      s(:return,
        s(:name, :n)))))
