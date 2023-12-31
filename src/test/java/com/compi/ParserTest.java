package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;

import java_cup.runtime.Symbol;


public class ParserTest {
  private String funMain = "function int main () { local int res <= 1+3|return res|@comentario\n}";
  private String funStr = "function string hola () {local string res <= \"hola\"|return \"3\"|}" + funMain;
  private String funInt = "function int hola () {local int res <= 1+3|return 3|}" + funMain;
  private String funBool = "function bool hola () {local int res <= 1+3|return true|}" + funMain;

  private Symbol testHelper (String christmassCode) throws Exception {
    IdLexer lexer = new IdLexer(new StringReader(christmassCode));
    Parser p = new Parser(lexer);
    return p.parse();
  }
  @Test
  public void testMain() throws Exception {
    Integer resultado = (Integer) testHelper(funMain).value;
    System.out.println(resultado);
  }

  @Test
  public void testStr() throws Exception {
    Integer resultado = (Integer) testHelper(funStr).value;
    System.out.println(resultado);
  }

  @Test
  public void testInt() throws Exception {
    Integer resultado = (Integer) testHelper(funInt).value;
    System.out.println(resultado);
  }

  @Test
  public void testBool() throws Exception {
    Integer resultado = (Integer) testHelper(funBool).value;
    System.out.println(resultado);
  }
}