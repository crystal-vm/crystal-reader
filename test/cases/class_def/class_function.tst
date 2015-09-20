class Pifi
  ofthen(3 , var)
  int ofthen(int n , ref m)
    n = n + m.index
    return n
  end
end
-- -- --
s(:expressions,
  s(:class, :Pifi,
    s(:derives, nil),
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
        s(:assign,
          s(:name, :n),
          s(:operator, "+",
            s(:name, :n),
            s(:field_access,
              s(:receiver,
                s(:name, :m)),
              s(:field,
                s(:name, :index))))),
        s(:return,
          s(:name, :n))))))
