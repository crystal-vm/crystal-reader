int retvar(Object n)
  int i = n.layout
  return i
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :retvar),
    s(:parameters,
      s(:parameter, :Object, :n)),
    s(:statements,
      s(:field_def, :Integer,
        s(:name, :i),
        s(:field_access,
          s(:receiver,
            s(:name, :n)),
          s(:field,
            s(:name, :layout)))),
      s(:return,
        s(:name, :i)))))
