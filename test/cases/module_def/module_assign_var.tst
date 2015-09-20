module Opers
  abba = 5
end
-- -- --
s(:expressions,
  s(:module, :Opers,
    s(:expressions,
      s(:assign,
        s(:name, :abba),
        s(:int, 5)))))
