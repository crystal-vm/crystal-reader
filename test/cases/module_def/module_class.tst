module Foo
  class Bar
    funcall(3 , var)
  end
end
-- -- --
s(:list,  [s(:module,  "Foo",  [s(:class,  "Bar",  nil,  [s(:call, 
  s(:name,  "funcall"), 
  s(:arguments, 
    s(:int,  3), 
    s(:name,  "var")))])])])
