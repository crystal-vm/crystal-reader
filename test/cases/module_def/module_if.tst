module Foo
  ref ofthen(int n)
    if(0)
      isit = 42
    else
      maybenot = 667
    end
  end
end
-- -- --
s(:expressions,
  s(:module, :Foo,
    s(:expressions,
      s(:function, :ref,
        s(:name, :ofthen),
        s(:parameters,
          s(:parameter, :int, :n)),
        s(:expressions,
          s(:if,
            s(:condition,
              s(:int, 0)),
            s(:if_true,
              s(:assign,
                s(:name, :isit),
                s(:int, 42))),
            s(:if_false,
              s(:assign,
                s(:name, :maybenot),
                s(:int, 667)))))))))
