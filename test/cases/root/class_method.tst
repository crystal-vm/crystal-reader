class FooBo
  Bar.call(35)
end

-- -- --
s(:list,  [s(:class,  "FooBo",  nil,  [s(:call, 
  s(:name,  "call"), 
  s(:arguments, 
    s(:int,  35)), 
  s(:receiver, 
    s(:module,  "Bar")))])])
