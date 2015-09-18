ref fibonaccit(int n)
  a = 0
  while(n)
    some = 43
    other = some * 4
  end
end
-- -- --
s(:list,  [s(:function,  :ref, 
  s(:name,  "fibonaccit"), 
  s(:parameters, 
    s(:field,  :int,  :n)), 
  s(:expressions, 
    s(:assign, 
      s(:name,  "a"), 
      s(:int,  0)), 
    s(:while, 
      s(:condition, 
        s(:name,  "n")), 
      s(:expressions, 
        s(:assign, 
          s(:name,  "some"), 
          s(:int,  43)), 
        s(:assign, 
          s(:name,  "other"), 
          s(:operator,  "*", 
            s(:name,  "some"), 
            s(:int,  4)))))))])
