class Ifi
  int ofthen(int n)
    if(0)
      isit = 42
    else
      maybenot = 667
    end
  end
end
-- -- --
s(:statements,
  s(:class, :Ifi,
    s(:derives, nil),
    s(:statements,
      s(:function, :Integer,
        s(:name, :ofthen),
        s(:parameters,
          s(:parameter, :Integer, :n)),
        s(:statements,
          s(:if_statement,
            s(:condition,
              s(:int, 0)),
            s(:true_statements,
              s(:assignment,
                s(:name, :isit),
                s(:int, 42))),
            s(:false_statements,
              s(:assignment,
                s(:name, :maybenot),
                s(:int, 667)))))))))
