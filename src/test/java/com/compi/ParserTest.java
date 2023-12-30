package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;


public class ParserTest {

  @Test
  public void parserAnalysis() throws Exception {
    String expresion = "function string hola () {local string res <= \"hola\"|return 3|} function int main () { local int res <= 1+3|return 3|}";
    IdLexer lexer = new IdLexer(new StringReader(expresion));
    Parser p = new Parser(lexer);
    Integer resultado = (Integer) p.parse().value;
    System.out.println(resultado);
  }
}