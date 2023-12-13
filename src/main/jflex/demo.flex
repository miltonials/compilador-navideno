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
// boolean = true|false // booleano
//if 
if = if
elif = elif
else = else
for = for
do = do
until = until
return  = return 
break = break
print = print
read = read
asignar = =;
disparador = main;



// Identifier = [a-zA-Z] [a-zA-Z0-9]* (?! (false | true) \b)  // identficador usado para declara a las personas, el identificador no puede ser true o false
// Identifier = [a-zA-Z] [a-zA-Z0-9]* // identficador usado para declara a las personas
Identifier = [a-zA-Z] [a-zA-Z0-9]* 


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

// Array de cualquier tipo de dato ejemplo: [1,2,3,4,5], ["hola","mundo"], [true,false]
// Array = "[" {ArrayContent} "]"
// ArrayContent = (ArrayElement ("," ArrayElement)*)?
// ArrayElement = (boolean | entero | decimal | string | character | Identifier)
Array =  "[" {ArrayContent}* "]" 
ArrayContent = ( [^,] | ("," [^,]) )* // contenido del array separado por comas 

%{

private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
}

private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
}
%}

%%

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

{whitespace}+ { /* skip white spaces */ }

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
// <YYINITIAL> {boolean} { return symbol(ParserSym.L_FATHERCHRISTMAS, yytext()); } // booleano
// <YYINITIAL> {Identifier} { return symbol(ParserSym.PERSONA, yytext()); }
<YYINITIAL> {Identifier} {
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
    return symbol(ParserSym.PERSONA, yytext());
}
<YYINITIAL> {string} { return symbol(ParserSym.L_DEDMOROZ, yytext()); } // cadena de caracteres
<YYINITIAL> {decimal}+ { return symbol(ParserSym.L_PERENOEL, Double.valueOf(yytext())); } // flotante
<YYINITIAL> {character} { return symbol(ParserSym.L_KRISKRINGLE, yytext()); } // caracter
// <YYINITIAL> {digit} { return symbol(ParserSym.L_PAPANOEL, yytext()); } // array
<YYINITIAL> {Array} { return symbol(ParserSym.L_PAPANOEL, yytext()); } // array
/* comentarios */
/* comentario de linea @,
comentario de bloque /_ contenido_/
*/
<YYINITIAL> {comment} { /* skip comments */ } // comentarios
// comentario de bloque /_ contenido_/
<YYINITIAL> "/_" {CommentContent}* "_/" { /* skip comments */ }


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
"," { return symbol(ParserSym.COMA, yytext()); }


// "boolean" { return symbol(ParserSym.L_FATHERCHRISTMAS, yytext()); }


<<EOF>> { return symbol(ParserSym.EOF); }

. {
    // throw new Error("Cadena ilegal <" + yytext() + ">"); 
    System.err.println("Cadena ilegal <" + yytext() + ">");
    //terminar el programaSystem.exit(1);
}
