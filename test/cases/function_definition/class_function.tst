int self.length( ref x )
  length
end
-- -- --
s(:expressions,
  s(:function, :int,
    s(:name, :length),
    s(:parameters,
      s(:parameter, :ref, :x)),
    s(:expressions,
      s(:name, :length)),
    s(:receiver, :self)))
