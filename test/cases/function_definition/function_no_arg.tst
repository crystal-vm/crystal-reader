int foo()
  5
end
-- -- --
s(:expressions, 
  s(:function,  :int, 
    s(:name,  :foo), 
    s(:parameters), 
    s(:expressions, 
      s(:int,  5))))
