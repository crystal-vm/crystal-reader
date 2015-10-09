int self.length( ref x )
  return 5
end
-- -- --
s(:statements,
  s(:function, :int,
    s(:name, :length),
    s(:parameters,
      s(:parameter, :ref, :x)),
    s(:statements,
      s(:return,
        s(:int, 5))),
    s(:receiver, :self)))
