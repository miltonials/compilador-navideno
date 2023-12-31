package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;

import java_cup.runtime.Symbol;


public class ParserTest {
  private String funMain = "function int main () { local int res <= 1+3|return 3|}";
  private String funStr = "function string hola () {local string res <= \"hola\"|return 3|}" + funMain;
  private String funInt = "function int hola () {local int res <= 1+3|return 3|}" + funMain;
  private String funBool = "function bool hola () {local int res <= 1+3|return 3|}" + funMain;

  @Test
  public void testMain() throws Exception {
    String expresion = funMain;
    IdLexer lexer = new IdLexer(new StringReader(expresion));
    Parser p = new Parser(lexer);
    Integer resultado = (Integer) p.parse().value;
    System.out.println(resultado);
  }

  @Test
  public void testStr() throws Exception {
    String expresion = funStr;
    IdLexer lexer = new IdLexer(new StringReader(expresion));
    Parser p = new Parser(lexer);
    Integer resultado = (Integer) p.parse().value;
    System.out.println(resultado);
  }

  @Test
  public void testInt() throws Exception {
    String expresion = funInt;
    IdLexer lexer = new IdLexer(new StringReader(expresion));
    Parser p = new Parser(lexer);
    Integer resultado = (Integer) p.parse().value;
    System.out.println(resultado);
  }

  @Test
  public void testBool() throws Exception {
    String expresion = funBool;
    System.out.println(expresion);
    IdLexer lexer = new IdLexer(new StringReader(expresion));
    Parser p = new Parser(lexer);
    Symbol resultado = (Symbol) p.parse();
    System.out.println(resultado);
  }
}