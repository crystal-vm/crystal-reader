while( n > 1)
  tmp = a
  a = b
  b = tmp + b
  puts(b)
  n = n - 1
end
-- -- --
s(:expressions, 
  s(:while, 
    s(:condition, 
      s(:operator,  ">", 
        s(:name,  :n), 
        s(:int,  1))), 
    s(:expressions, 
      s(:assign, 
        s(:name,  :tmp), 
        s(:name,  :a)), 
      s(:assign, 
        s(:name,  :a), 
        s(:name,  :b)), 
      s(:assign, 
        s(:name,  :b), 
        s(:operator,  "+", 
          s(:name,  :tmp), 
          s(:name,  :b))), 
      s(:call, 
        s(:name,  :puts), 
        s(:arguments, 
          s(:name,  :b))), 
      s(:assign, 
        s(:name,  :n), 
        s(:operator,  "-", 
          s(:name,  :n), 
          s(:int,  1))))))
