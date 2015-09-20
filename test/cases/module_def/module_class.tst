module Foo
  class Bar
    funcall(3 , var)
  end
end
-- -- --
s(:expressions,
  s(:module, :Foo,
    s(:expressions,
      s(:class, :Bar,
        s(:derives, nil),
        s(:expressions,
          s(:call,
            s(:name, :funcall),
            s(:arguments,
              s(:int, 3),
              s(:name, :var))))))))
