int retvar(int n )
  while( n > 5)
    n = n + 1
    return n
  end
end
-- -- --
s(:list,  [s(:function,  :int, 
  s(:name,  "retvar"), 
  s(:parameters, 
    s(:field,  :int,  :n)), 
  s(:expressions, 
    s(:while, 
      s(:condition, 
        s(:operator,  ">", 
          s(:name,  "n"), 
          s(:int,  5))), 
      s(:expressions, 
        s(:assign, 
          s(:name,  "n"), 
          s(:operator,  "+", 
            s(:name,  "n"), 
            s(:int,  1))), 
        s(:return, 
          s(:name,  "n"))))))])
