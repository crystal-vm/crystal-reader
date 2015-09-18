class Foo
  module Boo
    funcall(3 , var)
  end
end
-- -- --
s(:list,  [s(:class,  "Foo",  nil,  [s(:module,  "Boo",  [s(:call, 
  s(:name,  "funcall"), 
  s(:arguments, 
    s(:int,  3), 
    s(:name,  "var")))])])])
