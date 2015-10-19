class String

  String self.new_string(int len )
    len =  len << 2
    return super.new_object( len)
  end

  int length()
    return self.length
  end

  int plus(String str)
    my_length = self.length
    str_len = str.length()
    my_length = str_len + my_length
    new_string = self.new_string(my_length )
    i = 0
    while_plus( i - my_length)
      char = get(i)
      new_string.set(i , char)
      i = i + 1
    end
    i = 0
    while_plus( i - str_len)
      char = str.get(i)
      len = i + my_length
      new_string.set(  len , char)
      i = i + 1
    end
    return new_string
  end

end
-- -- --
s(:statements,
  s(:class, :String,
    s(:derives, nil),
    s(:statements,
      s(:function, :String,
        s(:name, :new_string),
        s(:parameters,
          s(:parameter, :Integer, :len)),
        s(:statements,
          s(:assignment,
            s(:name, :len),
            s(:operator_value, :<<,
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
      s(:function, :Integer,
        s(:name, :length),
        s(:parameters),
        s(:statements,
          s(:return,
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :length)))))),
      s(:function, :Integer,
        s(:name, :plus),
        s(:parameters,
          s(:parameter, :String, :str)),
        s(:statements,
          s(:assignment,
            s(:name, :my_length),
            s(:field_access,
              s(:receiver,
                s(:name, :self)),
              s(:field,
                s(:name, :length)))),
          s(:assignment,
            s(:name, :str_len),
            s(:call,
              s(:name, :length),
              s(:arguments),
              s(:receiver,
                s(:name, :str)))),
          s(:assignment,
            s(:name, :my_length),
            s(:operator_value, :+,
              s(:name, :str_len),
              s(:name, :my_length))),
          s(:assignment,
            s(:name, :new_string),
            s(:call,
              s(:name, :new_string),
              s(:arguments,
                s(:name, :my_length)),
              s(:receiver,
                s(:name, :self)))),
          s(:assignment,
            s(:name, :i),
            s(:int, 0)),
          s(:while_statement, :plus,
            s(:conditional,
              s(:operator_value, :-,
                s(:name, :i),
                s(:name, :my_length))),
            s(:statements,
              s(:assignment,
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
              s(:assignment,
                s(:name, :i),
                s(:operator_value, :+,
                  s(:name, :i),
                  s(:int, 1))))),
          s(:assignment,
            s(:name, :i),
            s(:int, 0)),
          s(:while_statement, :plus,
            s(:conditional,
              s(:operator_value, :-,
                s(:name, :i),
                s(:name, :str_len))),
            s(:statements,
              s(:assignment,
                s(:name, :char),
                s(:call,
                  s(:name, :get),
                  s(:arguments,
                    s(:name, :i)),
                  s(:receiver,
                    s(:name, :str)))),
              s(:assignment,
                s(:name, :len),
                s(:operator_value, :+,
                  s(:name, :i),
                  s(:name, :my_length))),
              s(:call,
                s(:name, :set),
                s(:arguments,
                  s(:name, :len),
                  s(:name, :char)),
                s(:receiver,
                  s(:name, :new_string))),
              s(:assignment,
                s(:name, :i),
                s(:operator_value, :+,
                  s(:name, :i),
                  s(:int, 1))))),
          s(:return,
            s(:name, :new_string)))))))
