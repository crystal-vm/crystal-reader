class Pifi
  ofthen(3 , var)
  int ofthen(int n , ref m)
    44
  end
end
-- -- --
s(:expressions, 
  s(:class,  :Pifi, 
    s(:derives,  nil), 
    s(:call, 
      s(:name,  :ofthen), 
      s(:arguments, 
        s(:int,  3), 
        s(:name,  :var))), 
    s(:function,  :int, 
      s(:name,  :ofthen), 
      s(:parameters, 
        s(:field,  :int,  :n), 
        s(:field,  :ref,  :m)), 
      s(:expressions, 
        s(:int,  44)))))
