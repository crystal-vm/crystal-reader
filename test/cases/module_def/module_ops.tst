module Opers
  int foo(int x)
    int abba = 5
    return abba + 5
  end
end
-- -- --
s(:expressions, 
  s(:module,  :Opers, 
    s(:function,  :int, 
      s(:name,  :foo), 
      s(:parameters, 
        s(:field,  :int,  :x)), 
      s(:expressions, 
        s(:name,  :int), 
        s(:assign, 
          s(:name,  :abba), 
          s(:int,  5)), 
        s(:return, 
          s(:operator,  "+", 
            s(:name,  :abba), 
            s(:int,  5)))))))
