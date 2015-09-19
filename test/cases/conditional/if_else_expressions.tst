if(3 > var)
  Object.initialize(3)
else
  var.new(33)
end
-- -- --
s(:expressions, 
  s(:if, 
    s(:condition, 
      s(:operator,  ">", 
        s(:int,  3), 
        s(:name,  :var))), 
    s(:if_true, 
      s(:call, 
        s(:name,  :initialize), 
        s(:arguments, 
          s(:int,  3)), 
        s(:receiver, 
          s(:module,  "Object")))), 
    s(:if_false,  [s(:call, 
  s(:name,  :new), 
  s(:arguments, 
    s(:int,  33)), 
  s(:receiver, 
    s(:name,  :var)))])))
