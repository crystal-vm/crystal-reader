class Fibo
  int fibonaccit(int n)
    int a = 0
    return a
  end
end

-- -- --
s(:expressions,
  s(:class, :Fibo,
    s(:derives, nil),
    s(:expressions,
      s(:function, :int,
        s(:name, :fibonaccit),
        s(:parameters,
          s(:parameter, :int, :n)),
        s(:expressions,
          s(:field_def, :int, :a,
            s(:int, 0)),
          s(:return,
            s(:name, :a)))))))
