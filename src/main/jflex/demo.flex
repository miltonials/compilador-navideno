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
digit = [0-9] // digito
digitnonzero = [1-9] // digito no cero
entero = {digitnonzero}{digit}* // entero
// decimales desde 0 hasta 999999...
decimales = 0|{digitnonzero}{digit}* // decimales
decimal = {decimales}("."{decimales})? // decimal
// 
letter = [a-zA-Z]
whitespace = [ \t]
LineTerminator = \r|\n|\r\n
Identifier = [a-zA-Z][a-zA-Z0-9]* // identficador usado para declara a las personas

boolean = true|false // booleano
string = \"[^\"]*\" // cadena de caracteres
character = \'[^\']\' // caracter

LineTerminator = \r|\n|\r\n // salto de linea
InputCharacter = [^\r\n] // caracter de entrada

/* Comentarios */
comment = {ComentarioLinea}|{ComentarioBloque}
// comentario de linea @
ComentarioLinea = "@" {InputCharacter}* {LineTerminator}?
// comentario de bloque /_ contenido_/
ComentarioBloque = "/_" {CommentContent}* "_"+ "/"
CommentContent = ( [^*] | ("*"+ [^/*]) )*

%{

private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
}

private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
}
%}

%%

{entero}+ { return symbol(ParserSym.SANTACLAUS, Integer.valueOf(yytext())); }
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
/* Identificadores */
/*
PERSONA  Identificador
PERENOEL	Flotante
FATHERCHRISTMAS	Booleano
KRISKRINGLE	Caracter
DEDMOROZ	String
PAPANOEL	Array
*/
<YYINITIAL> {Identifier} { return symbol(ParserSym.PERSONA, yytext()); }
<YYINITIAL> {boolean} { return symbol(ParserSym.FATHERCHRISTMAS, yytext()); }
<YYINITIAL> {string} { return symbol(ParserSym.DEDMOROZ, yytext()); }
<YYINITIAL> {decimal}+ { return symbol(ParserSym.PERENOEL, Double.valueOf(yytext())); }
<YYINITIAL> {character} { return symbol(ParserSym.KRISKRINGLE, yytext()); }
<YYINITIAL> {digit} { return symbol(ParserSym.PAPANOEL, yytext()); }

/* comentarios */
/* comentario de linea @,
comentario de bloque /_ contenido_/
*/
<YYINITIAL> {comment} { /* skip comments */ } // comentarios
// comentario de bloque /_ contenido_/
<YYINITIAL> "/_" {CommentContent}* "_"+ "/" { /* skip comments */ }


/*
abrecuento	(
cierrecuento	)
abreempaque	[
cierraempaque	]
abreregalo	{
cierraregalo	}
*/

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
