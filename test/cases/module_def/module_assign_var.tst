module Opers
  field int abba = 5
  field ref baab
end
-- -- --
s(:expressions,
  s(:module, :Opers,
    s(:expressions,
      s(:class_field, :int, :abba,
        s(:int, 5)),
      s(:class_field, :ref, :baab))))
