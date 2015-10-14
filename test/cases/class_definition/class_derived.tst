class Foo < Object
  field int fff = 3
  int func()
    return self.fff
  end
end
-- -- --
s(:statements,
  s(:class, :Foo,
    s(:derives, :Object),
    s(:statements,
      s(:class_field, :Integer, :fff,
        s(:int, 3)),
      s(:function, :Integer,
        s(:name, :func),
        s(:parameters),
        s(:statements,
          s(:return,
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :fff)))))))))
