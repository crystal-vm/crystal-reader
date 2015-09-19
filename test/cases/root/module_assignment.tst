module Fibo
  a = 5 + foo
  bar( b , a , r)
end

-- -- --
s(:expressions, 
  s(:module,  :Fibo, 
    s(:assign, 
      s(:name,  :a), 
      s(:operator,  "+", 
        s(:int,  5), 
        s(:name,  :foo))), 
    s(:call, 
      s(:name,  :bar), 
      s(:arguments, 
        s(:name,  :b), 
        s(:name,  :a), 
        s(:name,  :r)))))
