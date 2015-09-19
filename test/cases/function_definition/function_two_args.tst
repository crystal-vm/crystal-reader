int foo( int n ,ref  m)
  n
end
-- -- --
s(:expressions, 
  s(:function,  :int, 
    s(:name,  :foo), 
    s(:parameters, 
      s(:field,  :int,  :n), 
      s(:field,  :ref,  :m)), 
    s(:expressions, 
      s(:name,  :n))))
