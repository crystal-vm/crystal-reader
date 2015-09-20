class Foo
  module Boo
    funcall(3 , var)
  end
end
-- -- --
s(:expressions,
  s(:class, :Foo,
    s(:derives, nil),
    s(:expressions,
      s(:module, :Boo,
        s(:expressions,
          s(:call,
            s(:name, :funcall),
            s(:arguments,
              s(:int, 3),
              s(:name, :var))))))))
