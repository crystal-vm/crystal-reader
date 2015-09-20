class Foo < Object
  int field = 3
  int func()
    return self.field
  end
  ofthen(3 , var)
end
-- -- --
s(:expressions,
  s(:class, :Foo,
    s(:derives, :Object),
    s(:name, :int),
    s(:assign,
      s(:name, :field),
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
              s(:name, :field)))))),
    s(:call,
      s(:name, :ofthen),
      s(:arguments,
        s(:int, 3),
        s(:name, :var)))))
