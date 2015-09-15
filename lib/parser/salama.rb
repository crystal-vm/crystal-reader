require "ast"

module Parser

  # obviously a work in progress !!

  Citrus::Match.send :include , AST::Sexp

  Citrus.require "parser/bosl"

end
