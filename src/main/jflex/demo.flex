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
// boolean = true|false
boolean = true|false
// string = "([^"\\]|\\["\\bfnrt])*"
string = [:letter:]+


%{

private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
}

private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
}
%}

%%

{digit}+ { return symbol(ParserSym.SANTACLAUS, Integer.valueOf(yytext())); }
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

// Identifier = {letter}({letter}|{digit})*
// {Identifier}+ { return symbol(ParserSym.PERSONA, yytext()); }

/*
PERENOEL	Flotante
FATHERCHRISTMAS	Booleano
KRISKRINGLE	Caracter
DEDMOROZ	String
PAPANOEL	Array
abrecuento	(
cierrecuento	)
abreempaque	[
cierraempaque	]
abreregalo	{
cierraregalo	}
*/
boolean { return symbol(ParserSym.FATHERCHRISTMAS, yytext()); }
string { return symbol(ParserSym.DEDMOROZ, yytext()); }

"(" { return symbol(ParserSym.ABRECUENTO, yytext()); }
")" { return symbol(ParserSym.CIERRECUENTO, yytext()); }
"[" { return symbol(ParserSym.ABREEMPAQUE, yytext()); }
"]" { return symbol(ParserSym.CIERREEMPAQUE, yytext()); }
"{" { return symbol(ParserSym.ABREREGALO, yytext()); }
"}" { return symbol(ParserSym.CIERRAREGALO, yytext()); }


<<EOF>> { return symbol(ParserSym.EOF); }

. {
  throw new Error("Cadena ilegal <" + yytext() + ">");
}
