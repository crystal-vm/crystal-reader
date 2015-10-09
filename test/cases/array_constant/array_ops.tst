[ 3 + 4 , foo(22) ]
-- -- --
s(:expressions, 
  s(:array, 
    s(:operator,  "+", 
      s(:int,  3), 
      s(:int,  4)), 
    s(:call, 
      s(:name,  :foo), 
      s(:arguments, 
        s(:int,  22)))))
