while(1)
  tmp = a
  puts(b)
end
-- -- --
s(:expressions, 
  s(:while, 
    s(:condition, 
      s(:int,  1)), 
    s(:expressions, 
      s(:assign, 
        s(:name,  :tmp), 
        s(:name,  :a)), 
      s(:call, 
        s(:name,  :puts), 
        s(:arguments, 
          s(:name,  :b))))))
