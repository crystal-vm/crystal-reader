while(1)
  tmp = String.new()
  tmp.puts(i)
end
-- -- --
s(:list,  [s(:while, 
  s(:condition, 
    s(:int,  1)), 
  s(:expressions, 
    s(:assign, 
      s(:name,  "tmp"), 
      s(:call, 
        s(:name,  "new"), 
        s(:arguments), 
        s(:receiver, 
          s(:module,  "String")))), 
    s(:call, 
      s(:name,  "puts"), 
      s(:arguments, 
        s(:name,  "i")), 
      s(:receiver, 
        s(:name,  "tmp")))))])
