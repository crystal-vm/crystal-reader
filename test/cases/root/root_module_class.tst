module FooBo
  class Bar
    a = 5 + foo
  end
end

-- -- --
s(:expressions,
  s(:module, :FooBo,
    s(:expressions,
      s(:class, :Bar,
        s(:derives, nil),
        s(:expressions,
          s(:assign,
            s(:name, :a),
            s(:operator, "+",
              s(:int, 5),
              s(:name, :foo))))))))
