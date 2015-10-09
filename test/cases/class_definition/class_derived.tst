class Foo < Object
  field int fff = 3
  int func()
    return self.fff
  end
  ofthen(3 , var)
end
-- -- --
s(:expressions,
  s(:class, :Foo,
    s(:derives, :Object),
    s(:expressions,
      s(:class_field, :int, :fff,
        s(:int, 3)),
      s(:function, :int,
        s(:name, :func),
        s(:parameters),
        s(:expressions,
          s(:return,
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :fff)))))),
      s(:call,
        s(:name, :ofthen),
        s(:arguments,
          s(:int, 3),
          s(:name, :var))))))
