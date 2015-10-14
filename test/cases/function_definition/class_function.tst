int self.length( Object x )
  return 5
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :length),
    s(:parameters,
      s(:parameter, :Object, :x)),
    s(:statements,
      s(:return,
        s(:int, 5))),
    s(:receiver, :self)))
