class Foo < Object
  int Foo.test()
    43
  end
end
-- -- --
{:expression_list=>[{:module_name=>"Foo", :derived_name=>s(:module,  "Object"), :class_expressions=>[{:type=>"int", :receiver=>s(:module,  "Foo"), :function_name=>s(:name,  "test"), :parameter_list=>[], :expressions=>[s(:int,  43)], :end=>"end"}], :end=>"end"}]}
