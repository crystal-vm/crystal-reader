if(0)
  42
else
  667
end
-- -- --
s(:expressions,
  s(:if,
    s(:condition,
      s(:int, 0)),
    s(:if_true,
      s(:int, 42)),
    s(:if_false,
      s(:int, 667))))
