class Ifi
  int ofthen(int n)
    if(0)
      isit = 42
    else
      maybenot = 667
    end
  end
end
-- -- --
s(:expressions, 
  s(:class,  :Ifi, 
    s(:derives,  nil), 
    s(:function,  :int, 
      s(:name,  :ofthen), 
      s(:parameters, 
        s(:field,  :int,  :n)), 
      s(:expressions, 
        s(:if, 
          s(:condition, 
            s(:int,  0)), 
          s(:if_true, 
            s(:assign, 
              s(:name,  :isit), 
              s(:int,  42))), 
          s(:if_false,  [s(:assign, 
  s(:name,  :maybenot), 
  s(:int,  667))]))))))