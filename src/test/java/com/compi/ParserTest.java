package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java_cup.runtime.Symbol;



public class ParserTest {
  private String funMain = "function int main () { local int res <= 1+3|return res|@comentario\n}";
  private String funStr = "function string hola () {local string res <= \"hola\"|return \"3\"|}" + funMain;
  private String funInt = "function int hola () {";
  private String funfloat = "function int hola (int x, char y) {";
  private String funBool = "function bool hola () {";
  private String funChar = "function char hola () {";
  private String funArr = "function array hola () {";

  private Symbol testHelper (String christmasCode) throws Exception {
    System.out.println(christmasCode);
    IdLexer lexer = new IdLexer(new StringReader(christmasCode));
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
    program += "local int res <= 1|";
    program += "local int res1 <= ++(1)|";
    program += "local int res2 <= ++(((1)*(2)))|";
    program += "local int res3 <= ++((1))|";
    program += "local int res4 <= ++((1)- 23+1**2*5)|";
    program += "local int res5 <= (1+3)|";
    program += "local int res6 <= res1|";
    program += "local int res7 <= (res1)|";
    program += "local int res8 <= res1 + res2 + res3|";
    program += "local int res9 <= ++((res1)+ -23+res3**res6*5)|";
    program += "local int res10 <= ((res1)- 23+res3**res6*5)|";
    program += "local int res11 <= ((res1)- 23+res3**res6*5) + 4|";
    program += "local int res11 <= ++((res1)+ (-23)+res3**res6*5) + 4|";
    program += "local int res11 <= 3 - ((res1)+ 23+res3**res6*5)*-1 + 4|";
    program += "return ((res1)- 23+res3**res6*5)|}";//res1+res2+res3
    //program += "return 3|}";
    program += funMain;
    
    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test
  public void testFloat() throws Exception {
    String program = funfloat;
    program += "local float multiUnario <= 5 + ++--++1.1|";
    program += "local float res <= 1.3|";
    program += "local float res1 <= ++(1.34)|";
    program += "local float res2 <= ++(((1.3)*(0.3)))|";
    program += "local float res3 <= ++((1))|";
    program += "local float res4 <= ++((1) - 23+1**2*5)|";
    program += "local float res5 <= (1+3)|";
    program += "local float res6 <= res1|";
    program += "local float res7 <= (res1)|";
    program += "local float res8 <= res1 + res2 + res3|";
    program += "local float res9 <= ++((res1) - 23+res3**res6*5)|";
    program += "local float res10 <= ((res1) - 23+res3**res6*5)|";
    program += "local float res11 <= ((res1) - 23.6+res3**res6*5) + 4|";
    program += "local float res11 <= ++((res1) - 23+res3**res6*5) + 4|";
    program += "local float res11 <= 3 - ((res1) - 23.4+res3**res6*5) + 4|";
    program += "return ((res1)- ((23))+res3**res6*-5.4)|}";//res1+res2+res3
    //program += "return 3.4|}";
    program += funMain;
    
    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test
  public void testBool() throws Exception {
    String program = funBool;
    program += "local bool res1 <= true|";
    program += "local bool res2 <= true|";
    program += "local bool res3 <= true ^ false|";
    program += "local bool res4 <= true # false|";
    //program += "local bool res3 <= res1|";
    //program += "local bool res4 <= res1 && res2|";
    //program += "local bool res5 <= res1 || res2|";
    //program += "local bool res6 <= res1 && res2 || res3|";
    //program += "local bool res7 <= res1 && res2 || res3 && res4|";
    program += "return res4|}";
    //program = "function bool hola () {local int res <= 1+3|return true|}";
    program += funMain;
    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }
  
  @Test
  public void testCharmander() throws Exception {
    String program = funChar;
    program += "local char res1 <= 'a'|";
    program += "local char res2 <= 'b'|";
    program += "local char res3 <= 'c'|";
    program += "local char res4 <= 'd'|";
    program += "local char res5 <= 'e'|";
    program += "local char res6 <= 'f'|";
    program += "local char res7 <= 'g'|";
    program += "local char res8 <= 'h'|";
    program += "return res8|";
    program += "}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test void testArr() throws Exception {
    String program = funArr;
    program += "local array x <= [1]|";
    program += "local int m|";
    program += "m <= [123]|";
    program += "local array y <= [[2],[[2],[2]]]|";
    program += "local array z <= [\"d\"]|";
    program += "local array w <= [variable, 3]|";
    program += "local array w <= [variable, \"string\"]|";
    program += "return [1,x,y,z]|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }
}