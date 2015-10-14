int retvar(int n )
  while( n > 5)
    n = n + 1
    return n
  end
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :retvar),
    s(:parameters,
      s(:parameter, :Integer, :n)),
    s(:statements,
      s(:while_statement,
        s(:condition,
          s(:operator_value, :>,
            s(:name, :n),
            s(:int, 5))),
        s(:statements,
          s(:assignment,
            s(:name, :n),
            s(:operator_value, :+,
              s(:name, :n),
              s(:int, 1))),
          s(:return,
            s(:name, :n)))))))
