module Opers
  int foo(int x)
    int abba = x + self.index
    return abba + 5
  end
end
-- -- --
s(:expressions,
  s(:module, :Opers,
    s(:function, :int,
      s(:name, :foo),
      s(:parameters,
        s(:field, :int, :x)),
      s(:expressions,
        s(:name, :int),
        s(:assign,
          s(:name, :abba),
          s(:operator, "+",
            s(:name, :x),
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :index))))),
        s(:return,
          s(:operator, "+",
            s(:name, :abba),
            s(:int, 5)))))))
