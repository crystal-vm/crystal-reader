class Foo < Object
  ofthen(3 , var)
end
-- -- --
s(:expressions, 
  s(:class,  :Foo, 
    s(:derives,  :Object), 
    s(:call, 
      s(:name,  :ofthen), 
      s(:arguments, 
        s(:int,  3), 
        s(:name,  :var)))))
