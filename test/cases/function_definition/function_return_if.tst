int retvar(int n)
  if( n > 5)
    return 10
  else
    return 20
  end
end
-- -- --
s(:expressions,
  s(:function, :int,
    s(:name, :retvar),
    s(:parameters,
      s(:field, :int, :n)),
    s(:expressions,
      s(:if,
        s(:condition,
          s(:operator, ">",
            s(:name, :n),
            s(:int, 5))),
        s(:if_true,
          s(:return,
            s(:int, 10))),
        s(:if_false,
          s(:return,
            s(:int, 20)))))))
