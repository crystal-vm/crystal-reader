class FooBo
  Bar.call(35)
end

-- -- --
s(:expressions,
  s(:class, :FooBo,
    s(:derives, nil),
    s(:expressions,
      s(:call,
        s(:name, :call),
        s(:arguments,
          s(:int, 35)),
        s(:receiver,
          s(:module, "Bar"))))))
