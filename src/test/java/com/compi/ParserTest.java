package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java_cup.runtime.Symbol;



public class ParserTest {
  private String funMain = "function int main () { local int res <= 1+3|return res|@comentario\n}";
  private String funStr = "function string hola () {local string res <= \"hola\"|return \"3\"|}" + funMain;
  private String funInt = "function int hola () {";
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
    String program = funInt;
    program += "local int res1 <= ++(1)|";
    program += "local int res2 <= ++(((1)*(2)))|";
    program += "local int res3 <= ++((1))|";
    program += "local int res4 <= ++((1)-23+1**2*5)|";
    program += "local int res5 <= (1+3)|";
    program += "local int res6 <= res1|";
    program += "local int res7 <= (res1)|";
    program += "local int res8 <= res1 + res2 + res3|";
    program += "local int res9 <= ++((res1)-23+res3**res6*5)|";
    program += "local int res10 <= ((res1)-23+res3**res6*5)|";
    program += "local int res11 <= ((res1)-23+res3**res6*5) + 4|";
    program += "local int res11 <= ++((res1)-23+res3**res6*5) + 4|";
    program += "local int res11 <= 3 - ((res1)-23+res3**res6*5) + 4|";
    program += "return ((res1)-23+res3**res6*5)|}";//res1+res2+res3
    program += funMain;
    System.out.println(program);
    
    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test
  public void testBool() throws Exception {
    Integer resultado = (Integer) testHelper(funBool).value;
    System.out.println(resultado);
  }
}