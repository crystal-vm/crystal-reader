module Fibo
  int fibonaccit(int n)
    int a = 0
    return a
  end

  fibonaccit( 10 )
end

-- -- --
s(:expressions,
  s(:module, :Fibo,
    s(:function, :int,
      s(:name, :fibonaccit),
      s(:parameters,
        s(:parameter, :int, :n)),
      s(:expressions,
        s(:name, :int),
        s(:assign,
          s(:name, :a),
          s(:int, 0)),
        s(:return,
          s(:name, :a)))),
    s(:call,
      s(:name, :fibonaccit),
      s(:arguments,
        s(:int, 10)))))
