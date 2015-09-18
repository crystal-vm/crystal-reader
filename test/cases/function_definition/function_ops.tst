int foo(int x)
 int abba = 5
 abba + 5
end
-- -- --
s(:list,  [s(:function,  :int, 
  s(:name,  "foo"), 
  s(:parameters, 
    s(:field,  :int,  :x)), 
  s(:expressions, 
    s(:name,  "int"), 
    s(:assign, 
      s(:name,  "abba"), 
      s(:int,  5)), 
    s(:operator,  "+", 
      s(:name,  "abba"), 
      s(:int,  5))))])
