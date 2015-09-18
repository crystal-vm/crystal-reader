if(0)
  42
end
-- -- --
s(:list,  [s(:if, 
  s(:condition, 
    s(:int,  0)), 
  s(:if_true, 
    s(:int,  42)), 
  s(:if_false,  nil))])
