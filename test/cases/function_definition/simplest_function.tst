int foo(ref x)
  5
end
-- -- --
s(:expressions,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :ref, :x)),
    s(:expressions,
      s(:int, 5))))
