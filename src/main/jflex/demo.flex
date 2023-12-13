package com.compi;

/* Ejemplo de JFlex: Especificación parcial de lexer para un lenguaje de programación personalizado en Java */
import java_cup.runtime.*;

/**
 * Esta clase es un ejemplo simple de lexer para un lenguaje de programación personalizado.
 * El lexer tokeniza la entrada según reglas específicas.
 */
%%
%public
%class IdLexer
%cup
// Expresiones regulares para tokens
digit = [0-9] // dígito
digitnonzero = [1-9] // dígito no cero
entero = {digitnonzero}{digit}* // entero
decimales = 0|{digitnonzero}{digit}* // decimales
decimal = {decimales}("."{decimales})? // decimal
letter = [a-zA-Z]
whitespace = [ \t]
LineTerminator = \r|\n|\r\n
if = if
elif = elif
else = else
for = for
do = do
until = until
return = return
break = break
print = print
read = read
asignar = =;
disparador = main;
Identifier = [a-zA-Z] [a-zA-Z0-9]* // identificador
string = \"[^\"]*\" // cadena de caracteres
character = \'[^\']\' // carácter
LineTerminator = \r|\n|\r\n // salto de línea
InputCharacter = [^\r\n] // carácter de entrada

// Comentarios
comment = {ComentarioLinea}|{ComentarioBloque}
ComentarioLinea = "@" {InputCharacter}* {LineTerminator}?
ComentarioBloque = "/_" {CommentContent}* "_/"
CommentContent = ( [^*] | ("*"+ [^/*]) )*

// Definición de Array
Array =  "[" {ArrayContent}* "]"
ArrayContent = ( [^,] | ("," [^,]) )*

/**
 * Método para crear un símbolo solo con el tipo.
 * @param type El tipo del símbolo.
 * @return El símbolo creado.
 */
%{
private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
}

/**
 * Método para crear un símbolo con tipo y valor.
 * @param type El tipo del símbolo.
 * @param value El valor del símbolo.
 * @return El símbolo creado.
 */
private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
}
%}

%%

// Definiciones de tokens
{entero}+ { return symbol(ParserSym.L_SANTACLAUS, Integer.valueOf(yytext())); }
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
"=" { return symbol(ParserSym.ENTREGA, yytext()); }

{whitespace}+ { /* omitir espacios en blanco */ }

{LineTerminator} {
  yyline++;
  yycolumn = 1;
}
/* Identificadores */
/*
PERSONA  Identificador
L_PERENOEL	Flotante
L_FATHERCHRISTMAS	Booleano
L_KRISKRINGLE	Caracter
L_DEDMOROZ	String
L_PAPANOEL	Array
*/
<YYINITIAL> {Identifier} {
    // Verifica si es una palabra reservada
    if (yytext().equals("true") || yytext().equals("false")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.L_FATHERCHRISTMAS, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    /*terminal Integer ELFO;//IF
      terminal Integer HADA;//ELSE
      terminal Integer DUENDE;//ELSE
      terminal Integer ENVUELVE;//FOR
      terminal Integer HACE;//DO
      terminal Integer REVISA;//UNTIL
      terminal Integer ENVIA;//RETURN
      terminal Integer CORTA;//BREAK
      terminal Integer NARRA;//PRINT
    */
    if (yytext().equals("if")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.ELFO, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("elif")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.HADA, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("else")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.DUENDE, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("for")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.ENVUELVE, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("do")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.HACE, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("until")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.REVISA, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("return")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.ENVIA, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("break")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.CORTA, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("print")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.NARRA, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("read")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.ESCUCHA, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("main")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.MAIN, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("int")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.SANTACLAUS, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("float")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.PERENOEL, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("char")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.KRISKRINGLE, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("string")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.DEDMOROZ, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("bool")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.FATHERCHRISTMAS, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    if (yytext().equals("array")) {
        //yypushback(yytext().length()); // Vuelve atrás para que las palabras reservadas no se consuman
        return symbol(ParserSym.PAPANOEL, yytext()); // Puedes definir un símbolo diferente para booleanos si es necesario
    }
    // Si no es una palabra reservada, es un identificador
    return symbol(ParserSym.PERSONA, yytext());
}
// Token de cadena
<YYINITIAL> {string} { return symbol(ParserSym.L_DEDMOROZ, yytext()); }

// Token decimal
<YYINITIAL> {decimal}+ { return symbol(ParserSym.L_PERENOEL, Double.valueOf(yytext())); }

// Token de carácter
<YYINITIAL> {character} { return symbol(ParserSym.L_KRISKRINGLE, yytext()); }

// Token de Array
<YYINITIAL> {Array} { return symbol(ParserSym.L_PAPANOEL, yytext()); }

// Omitir comentarios
<YYINITIAL> {comment} { /* omitir comentarios */ }

// Caracteres especiales
<YYINITIAL> "(" { return symbol(ParserSym.ABRECUENTO, yytext()); }
<YYINITIAL> ")" { return symbol(ParserSym.CIERRECUENTO, yytext()); }
<YYINITIAL> "[" { return symbol(ParserSym.ABREEMPAQUE, yytext()); }
<YYINITIAL> "]" { return symbol(ParserSym.CIERREEMPAQUE, yytext()); }
<YYINITIAL> "{" { return symbol(ParserSym.ABREREGALO, yytext()); }
<YYINITIAL> "}" { return symbol(ParserSym.CIERRAREGALO, yytext()); }
<YYINITIAL> "," { return symbol(ParserSym.COMA, yytext()); }

// Token de fin de archivo
<<EOF>> { return symbol(ParserSym.EOF); }

// Carácter ilegal
. {
    System.err.println("Carácter ilegal <" + yytext() + ">");
}
