class Foo < Object
  int test()
    return 43
  end
end
-- -- --
s(:statements,
  s(:class, :Foo,
    s(:derives, :Object),
    s(:statements,
      s(:function, :Integer,
        s(:name, :test),
        s(:parameters),
        s(:statements,
          s(:return,
            s(:int, 43)))))))
