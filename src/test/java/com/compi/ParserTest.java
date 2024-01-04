package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java_cup.runtime.Symbol;



public class ParserTest {
  private String funMain = "function int main () { local int res <= 1+3|return res|@comentario\n}";
  private String funStr = "function int hola () {local string res <= \"hola\"|return 3|}";
  private String funInt = "function int hola () {";
  private String funfloat = "function float hola (int x, char y) {";
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
    funStr += funMain;
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
    program += "local float multiUnario <= 5.1 + 1.1|";
    program += "local float res <= 1.3|";
    program += "local float res1 <= ++(1.34)|";
    program += "local float res2 <= ++(((1.3)*(0.3)))|";
    program += "local float res3 <= ++((1.1))|";
    program += "local float res4 <= ++((1.1) - 23.1 + 1.0**2.0*5.0)|";
    program += "local float res5 <= (1.3)|";
    program += "local float res6 <= res1*1.0|";
    program += "local float res7 <= (res1*1.0)|";
    program += "local float res8 <= res1*1.0 + res2*1.0 + res3*1.0|";
    program += "return (res*1.1 - ((23.1)) + ((res3 *1.2) ** res6 *1.3) * -5.4)|}";//res1+res2+res3
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
    program += "local int res5 <= 12 + 21|";
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
    String program = funInt + "\n";
    program += "local array x <= [1]|";
    program += "local int m|";
    program += "m <= [123]|";
    program += "local array y <= [2, tres, cuatro]|";
    program += "local array w <= [variable, 3]|";
    program += "local array w <= [mil, variable]|";
    program += "return 1|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test void testStructures() throws Exception {
    String program = funInt + "\n";
    program += "local array x <= [1]|";
    //if
    program += "if (true) {";
    program += "local int m|";
    program += "m <= [123]|}";
    //if else
    program += "if (true) {";
    program += "local int m|";
    program += "m <= [123]|}";
    program += "else {";
    program += "local int m|";
    program += "m <= [123]|}";
    //if else if
    program += "if (true) {";
    program += "local int m|";
    program += "m <= [123]|}";
    program += "elif (true) {";
    program += "local int m|";
    program += "m <= [123]|}";
    program += "else {";
    program += "local int m|";
    program += "m <= [123]|}";

    //if dentro de if
    program += "if (true) {";
    program += "local int m|";
    program += "m <= [123]|";
    program += "if (true) {";
    program += "local int m|";
    program += "m <= [123]|}}";
    program += "elif (true) {";
    program += "local int m|";
    program += "m <= [123]|}";
    program += "else {";
    program += "local int m|";
    program += "m <= [123]|}";
    
    program += "return 2|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test
  public void testLoops() throws Exception{
    String program = funChar + "\n";
    program += "local array x <= [1]|";
    //for
    program += "for (local int res <= 1| 2<5 | ++res) {";
    program += "local int m|";

    program += "if (true) {";
    program += "local int m|";
    program += "break|";
    program += "m <= [123]|}";

    program += "m <= [123]|}";

    // do while
    program += "do {";
    program += "local int m|";
    program += "m <= [123]|}";
    program += "until (true)|";
    
    program += "return '5'|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test
  public void testIO() throws Exception{
    String program = funInt + "\n";
    
    program += "print(\"hola\")|";
    program += "print(variable)|";

    program += "read(variable)|";
    program += "read(\"ingrese algo:\")|";
    program += "local string identificador <= read()|";
    program += "local string identificador <= read(\"ingrese algo:\")|";

    program += "local array x <= [1]|";
    program += "return 1|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }

  @Test
  public void miTest() throws Exception {
    String program = funInt;

    //program += "local int x <= 21 + 1|";
    program += "local int miVariable <= 13|";
    program += "local int m <= miVariable + x ** x + 1|";
    program += "local int a <= 12 + x + 1|";

    program += "local float x <= 2.1 + 1.0|";
    program += "local float miVariable <= 1.3|";
    program += "local float m <= miVariable*1.0 + x*1.0 ** x*1.0 + 1.1|";
    program += "local float a <= 12.1 + x*1.0 + 2.0 |";
    program += "local float a <= (x*1.0 + y*1.0)|";
    program += "local float a <= (x*1.0 + y*1.0 + 1.0 + y*1.0) + 1.0|";


    program += "return 1|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
    System.out.println(resultado);
  }
}