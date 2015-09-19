module FooBo
  class Bar
    a = 5 + foo
  end
end

-- -- --
s(:expressions, 
  s(:module,  :FooBo, 
    s(:class,  :Bar, 
      s(:derives,  nil), 
      s(:assign, 
        s(:name,  :a), 
        s(:operator,  "+", 
          s(:int,  5), 
          s(:name,  :foo))))))
