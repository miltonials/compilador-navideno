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
whitespace = [ \t]
LineTerminator = \r|\n|\r\n

%{

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

%%

{digit}+ { return symbol(ParserSym.SantaClaus, Integer.valueOf(yytext())); }
"+" { return symbol(ParserSym.RUDOLPH, yytext()); }
"-" { return symbol(ParserSym.DASHER, yytext()); }
"/" { return symbol(ParserSym.DANCER, yytext()); }
"//" { return symbol(ParserSym.PRANCER, yytext()); }
"*" { return symbol(ParserSym.VIXEN, yytext()); }
"~" { return symbol(ParserSym.COMET, yytext()); }
"**" { return symbol(ParserSym.CUPID, yytext()); }
"++" { return symbol(ParserSym.GRINCH, yytext()); }
"--" { return symbol(ParserSym.QUIEN, yytext()); }
"<" { return symbol(ParserSym.HERMEY, yytext()); }
"<=" { return symbol(ParserSym.BUDDY, yytext()); }
">" { return symbol(ParserSym.JINGLE, yytext()); }
">=" { return symbol(ParserSym.JANGLE, yytext()); }
"==" { return symbol(ParserSym.PEPPERMINT, yytext()); }
"!=" { return symbol(ParserSym.WUNORSE, yytext()); }
"^" { return symbol(ParserSym.MELCHOR, yytext()); }
"#" { return symbol(ParserSym.GASPAR, yytext()); }
"!" { return symbol(ParserSym.BALTASAR, yytext()); }
"|" { return symbol(ParserSym.FINREGALO, yytext()); }

{whitespace}+ { /* skip white spaces */ }

{LineTerminator} {
  yyline++;
  yycolumn = 1;
}

[^\s] {
  return symbol(ParserSym.FINREGALO, yytext());
}

<<EOF>> { return symbol(ParserSym.EOF); }

. {
  throw new Error("Cadena ilegal <" + yytext() + ">");
}
