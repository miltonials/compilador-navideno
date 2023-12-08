package com.compi;

/* JFlex example: partial Java language lexer specification */
import java_cup.runtime.*;

/**
  * This class is a simple example lexer.
  */
%%
%public
%class IdLexer
%cup
digit = [0-9]
letter = [a-zA-Z]
whitespace = [ \t\n]

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

%%

{digit}+ { return symbol(ParserSym.NUMBER, Integer.valueOf(yytext())); }
"(" { return symbol(ParserSym.LPAREN, yytext()); }
")" { return symbol(ParserSym.RPAREN, yytext()); }
"+" { return symbol(ParserSym.PLUS, yytext()); }
"*" { return symbol(ParserSym.TIMES, yytext()); }

{whitespace}+ { /* skip white spaces */ }
[^\s]                                   { throw new Error("Cadena ilegal <" + yytext() + ">"); }

<<EOF>> { return symbol(ParserSym.EOF); }

. {
  throw new Error("Cadena ilegal <" + yytext() + ">");
}