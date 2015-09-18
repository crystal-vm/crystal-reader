int foo(ref x)
  a = 5
end

foo( 3 )
-- -- --
s(:list,  [s(:function,  :int, 
  s(:name,  "foo"), 
  s(:parameters, 
    s(:field,  :ref,  :x)), 
  s(:expressions, 
    s(:assign, 
      s(:name,  "a"), 
      s(:int,  5)))), s(:call, 
  s(:name,  "foo"), 
  s(:arguments, 
    s(:int,  3)))])
