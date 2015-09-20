module Opers
  int foo(int x)
    int abba = self.index
    return abba + 5
  end
end
-- -- --
s(:expressions,
  s(:module, :Opers,
    s(:function, :int,
      s(:name, :foo),
      s(:parameters,
        s(:parameter, :int, :x)),
      s(:expressions,
        s(:field_def, :int, :abba,
          s(:field_access,
            s(:receiver,
              s(:name, :self)),
            s(:field,
              s(:name, :index)))),
        s(:return,
          s(:operator, "+",
            s(:name, :abba),
            s(:int, 5)))))))
