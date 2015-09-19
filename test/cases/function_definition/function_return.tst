int retvar(ref n)
  int i = 5
  return i
end
-- -- --
s(:expressions, 
  s(:function,  :int, 
    s(:name,  :retvar), 
    s(:parameters, 
      s(:field,  :ref,  :n)), 
    s(:expressions, 
      s(:name,  :int), 
      s(:assign, 
        s(:name,  :i), 
        s(:int,  5)), 
      s(:return, 
        s(:name,  :i)))))
