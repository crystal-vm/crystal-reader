int retvar(int n)
  if( n > 5)
    return 10
  else
    return 20
  end
end
-- -- --
s(:statements,
  s(:function, :int,
    s(:name, :retvar),
    s(:parameters,
      s(:parameter, :int, :n)),
    s(:statements,
      s(:if_statement,
        s(:condition,
          s(:operator_value, :>,
            s(:name, :n),
            s(:int, 5))),
        s(:true_statements,
          s(:return,
            s(:int, 10))),
        s(:false_statements,
          s(:return,
            s(:int, 20)))))))
