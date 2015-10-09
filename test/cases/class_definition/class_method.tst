class Foo < Object
  int test()
    43
  end
end
-- -- --
s(:expressions,
  s(:class, :Foo,
    s(:derives, :Object),
    s(:expressions,
      s(:function, :int,
        s(:name, :test),
        s(:parameters),
        s(:expressions,
          s(:int, 43))))))
