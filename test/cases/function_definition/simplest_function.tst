int foo(ref x)
  a = 1
end
-- -- --
s(:statements,
  s(:function, :int,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :ref, :x)),
    s(:statements,
      s(:assignment,
        s(:name, :a),
        s(:int, 1)))))
