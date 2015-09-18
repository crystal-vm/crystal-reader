class Foo < Object
  ofthen(3 , var)
end
-- -- --
s(:list,  [s(:class,  "Foo", 
  s(:module,  "Object"),  [s(:call, 
  s(:name,  "ofthen"), 
  s(:arguments, 
    s(:int,  3), 
    s(:name,  "var")))])])
