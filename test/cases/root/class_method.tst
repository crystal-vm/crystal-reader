class FooBo
  int main()
    Bar.call(35)
  end
end

-- -- --
s(:statements,
  s(:class, :FooBo,
    s(:derives, nil),
    s(:statements,
      s(:function, :Integer,
        s(:name, :main),
        s(:parameters),
        s(:statements,
          s(:call,
            s(:name, :call),
            s(:arguments,
              s(:int, 35)),
            s(:receiver,
              s(:class_name, :Bar))))))))
