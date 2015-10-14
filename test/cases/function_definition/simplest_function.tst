int foo(Class x)
  a = 1
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :foo),
    s(:parameters,
      s(:parameter, :Class, :x)),
    s(:statements,
      s(:assignment,
        s(:name, :a),
        s(:int, 1)))))
