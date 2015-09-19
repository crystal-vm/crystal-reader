module Foo
  class Bar
    funcall(3 , var)
  end
end
-- -- --
s(:expressions, 
  s(:module,  :Foo, 
    s(:class,  :Bar, 
      s(:derives,  nil), 
      s(:call, 
        s(:name,  :funcall), 
        s(:arguments, 
          s(:int,  3), 
          s(:name,  :var))))))
