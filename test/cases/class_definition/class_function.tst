class Pifi

  int self.ofthen(int n , Object m)
    n = n + m.index
    return n
  end
end
-- -- --
s(:statements,
  s(:class, :Pifi,
    s(:derives, nil),
    s(:statements,
      s(:function, :Integer,
        s(:name, :ofthen),
        s(:parameters,
          s(:parameter, :Integer, :n),
          s(:parameter, :Object, :m)),
        s(:statements,
          s(:assignment,
            s(:name, :n),
            s(:operator_value, :+,
              s(:name, :n),
              s(:field_access,
                s(:receiver,
                  s(:name, :m)),
                s(:field,
                  s(:name, :index))))),
          s(:return,
            s(:name, :n))),
        s(:receiver, :self)))))
