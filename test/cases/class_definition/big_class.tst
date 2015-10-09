class String

  ref self.new_string(int len )
    len =  len << 2
    return super.new_object( len)
  end

  int length()
    return self.length
  end

  int plus(ref str)
    my_length = self.length
    str_len = str.length()
    my_length = str_len + my_length
    new_string = self.new_string(my_length )
    i = 0
    while( i < my_length)
      char = get(i)
      new_string.set(i , char)
      i = i + 1
    end
    i = 0
    while( i < str_len)
      char = str.get(i)
      len = i + my_length
      new_string.set(  len , char)
      i = i + 1
    end
    return new_string
  end

end
-- -- --
s(:expressions,
  s(:class, :String,
    s(:derives, nil),
    s(:expressions,
      s(:function, :ref,
        s(:name, :new_string),
        s(:parameters,
          s(:parameter, :int, :len)),
        s(:expressions,
          s(:assign,
            s(:name, :len),
            s(:operator, "<<",
              s(:name, :len),
              s(:int, 2))),
          s(:return,
            s(:call,
              s(:name, :new_object),
              s(:arguments,
                s(:name, :len)),
              s(:receiver,
                s(:name, :super))))),
        s(:receiver, :self)),
      s(:function, :int,
        s(:name, :length),
        s(:parameters),
        s(:expressions,
          s(:return,
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :length)))))),
      s(:function, :int,
        s(:name, :plus),
        s(:parameters,
          s(:parameter, :ref, :str)),
        s(:expressions,
          s(:assign,
            s(:name, :my_length),
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :length)))),
          s(:assign,
            s(:name, :str_len),
            s(:call,
              s(:name, :length),
              s(:arguments),
              s(:receiver,
                s(:name, :str)))),
          s(:assign,
            s(:name, :my_length),
            s(:operator, "+",
              s(:name, :str_len),
              s(:name, :my_length))),
          s(:assign,
            s(:name, :new_string),
            s(:call,
              s(:name, :new_string),
              s(:arguments,
                s(:name, :my_length)),
              s(:receiver,
                s(:name, :self)))),
          s(:assign,
            s(:name, :i),
            s(:int, 0)),
          s(:while,
            s(:condition,
              s(:operator, "<",
                s(:name, :i),
                s(:name, :my_length))),
            s(:expressions,
              s(:assign,
                s(:name, :char),
                s(:call,
                  s(:name, :get),
                  s(:arguments,
                    s(:name, :i)))),
              s(:call,
                s(:name, :set),
                s(:arguments,
                  s(:name, :i),
                  s(:name, :char)),
                s(:receiver,
                  s(:name, :new_string))),
              s(:assign,
                s(:name, :i),
                s(:operator, "+",
                  s(:name, :i),
                  s(:int, 1))))),
          s(:assign,
            s(:name, :i),
            s(:int, 0)),
          s(:while,
            s(:condition,
              s(:operator, "<",
                s(:name, :i),
                s(:name, :str_len))),
            s(:expressions,
              s(:assign,
                s(:name, :char),
                s(:call,
                  s(:name, :get),
                  s(:arguments,
                    s(:name, :i)),
                  s(:receiver,
                    s(:name, :str)))),
              s(:assign,
                s(:name, :len),
                s(:operator, "+",
                  s(:name, :i),
                  s(:name, :my_length))),
              s(:call,
                s(:name, :set),
                s(:arguments,
                  s(:name, :len),
                  s(:name, :char)),
                s(:receiver,
                  s(:name, :new_string))),
              s(:assign,
                s(:name, :i),
                s(:operator, "+",
                  s(:name, :i),
                  s(:int, 1))))),
          s(:return,
            s(:name, :new_string)))))))
