module Soho
  ofthen(3 , var)
  int ofthen(int n,ref m )
    return 44
  end
end
-- -- --
s(:expressions,
  s(:module, :Soho,
    s(:expressions,
      s(:call,
        s(:name, :ofthen),
        s(:arguments,
          s(:int, 3),
          s(:name, :var))),
      s(:function, :int,
        s(:name, :ofthen),
        s(:parameters,
          s(:parameter, :int, :n),
          s(:parameter, :ref, :m)),
        s(:expressions,
          s(:return,
            s(:int, 44)))))))
