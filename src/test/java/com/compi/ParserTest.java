package com.compi;

import java.io.StringReader;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java_cup.runtime.Symbol;



public class ParserTest {
  private String funMain = "function int main () { local int res <= 1|return 1|}";
  private String funMainAlt = "function int main () { ";
  private String funStr = "function int hola (string paramA, int paramB, char paramC) {";
  private String funInt = "function int hola () {";
  private String funfloat = "function float hola (int x, char y) {";
  private String funBool = "function bool hola () {";
  private String funChar = "function char hola () {";

  private Symbol testHelper (String christmasCode) throws Exception {
    System.out.println(christmasCode);
    IdLexer lexer = new IdLexer(new StringReader(christmasCode));
    Parser p = new Parser(lexer);
    return p.parse();
  }
  @Test
  public void testMain() throws Exception {
    Integer resultado = (Integer) testHelper(funMain).value;
  }

  @Test
  public void testStr() throws Exception {
    String program = funStr;
    program += "local string res <= \"hola\"|";
    program += "local string res2 <= \"hola\"|";
    program += "local int resInt <= 3|";
    program += "return resInt|}";
    program += funMain;
    Integer resultado = (Integer) testHelper(program).value;
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
  }

  @Test
  public void testFloat() throws Exception {
    String program = funfloat;
    program += "local float multiUnario <= 5.1 + 1.1|local float fl1|\n" +
            "\tlocal float fl1<=56.6|";
    program += "local float res <= 1.3|local bool mibool <= true|";
    program += "res <= 2.2|arr[lit] <= 'c'|";
    program += "local int in1<= --fl1 ~ -14/++in1+7- 15 **  arr[67] * func1 (hola, true, \"hola mundo\", 4.5, 'a') |";
    program += "mibool <= (3.7 * fl1 + (-45.6~76)) < 56 ^ true # mibool # !mibool  | @semantico literal 76\n";

    program += "miFunc(miFunc(a),'a')|";
    program += "local bool bl0 <= 6.7 != 8.9|";
    program += "local bool bl1 <= in1 => fl1 ^ false # !(func2(3,in1) > 56)|";

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
    program += "function float hola (int x, char y){" +
            "\treturn b1|\n" +
            "}";
    program += funMain;
    
    Integer resultado = (Integer) testHelper(program).value;
  }

  @Test
  public void testBool() throws Exception {
    String program = funBool;
    program += "local bool res1 <= true|";
    program += "local bool res2 <= true|";
    program += "local bool res3 <= true ^ false|";
    program += "local bool res4 <= true # false|";
    program += "local int res5 <= 12 + 21|";
    program += "res3 <= res1#false|";
    program += "local bool res4 <= res1#false ^ res2#false|";
    program += "local bool res5 <= res1#false # res2#false|";
    program += "local bool res6 <= res1#false ^ res2#false # res3#false|";
    program += "local bool res7 <= res1#false ^ res2#false # res3#false ^ res4#false|";
    program += "return res4|}";
    //program = "function bool hola () {local int res <= 1+3|return true|}";
    program += funMain;
    Integer resultado = (Integer) testHelper(program).value;
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
    program += "res8 <= 'h'|";
    program += "return res8|";
    program += "}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
  }

  @Test void testArr() throws Exception {
    String program = funInt + "\n";
    //program += "local int[2] x|";
    program += "local int[3] x <= [1, variable, 2,3, variable2 ,5, xyz]|";
    program += "local char[3] x <= ['1',variable, '2','3','4']|";
    program += "local char[3] x <= [1, 's']|";
    program += "local int m|";
    program += "m <= [123]|";
    program += "local int[x] y <= [2, tres, cuatro]|";
    program += "local int[x+2 - 2] w <= [variable, 3]|";
    program += "local int[x+2 + -2] w <= [mil, variable, (func2(3,in1) > 56)]|";
    program += "return 1|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
  }

  @Test void testStructures() throws Exception {
    String program = funInt + "\n";
    program += "local int[1] x <= [1]|";
    program += "local int m|";
    program += "m <= [123]|";

    //if

    program += "if (true^false) {";
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
  }

  @Test
  public void testLoops() throws Exception{
    String program = funChar + "\n";
    program += "local int[1] x <= [1]|";
    program += "for (local int res <= 1| 2 < 5 | ++res) {";
    program += "local int m|break|}";
    //for

    program += "for (local int res <= 1| 2<5 | ++res) {";
    program += "local int m|";

    program += "if (true) {";
    program += "local int m|";
    program += "break|";
    program += "m <= [123]|}";
    program += "break|";
    program += "m <= [123]|}";

    // do while
    program += "do {";
    program += "local int m|";
    program += "m <= [123]|}";
    program += "until (true)|";

    program += "return '5'|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
  }

  @Test
  public void testIO() throws Exception{
    String program = funInt + "\n";
    
    program += "print(\"hola\")|";
    program += "print(variable)|";

    program += "read(variable)|";
    //program += "local string identificador <= read()|";
    //program += "local string identificador <= read(\"ingrese algo:\")|";

    program+= "local int[1] x <= [1]|";
    program += "return 1|}";
    program += funMain;

    Integer resultado = (Integer) testHelper(program).value;
  }

  @Test
  public void miTest() throws Exception {
    String program = funMainAlt;
    program += "local int temp1 <= 1 + 2 + 3 + -4 + 5 + 6|";//13✅
    program += "print(\"hola\")|";
    program += "print(temp1)|";
    program += "print((1.1 + 3.3 + 5.5 + 7.7 + 9.9 - ( 1.1 + 3.3 + 5.5 + 7.7 + 9.9 + 1.0)))|";
    program += "print(1 - (2 - (10 + (5 + 5 + 5))) + 5 + 5)|";
    program += "print(5/5)|";
    program += "print(\"Soy un string\")|";

    /*
    program += "local int temp2 <= 5 + 5 - 5 + 5 - 5 + 5|";//10✅
    program += "local int temp3 <= (5 + 5 + 5) + (5 + 5 + 5)|";//30✅
    program += "local int temp4 <= 5 + 5 + (5 + 5) + 5|";//25✅
    program += "local int temp5 <= 0 - (10 + 5) + 4 + 1 + 2 + 3|";//-5✅
    program += "local int temp6 <= (0 - 10 + 5 + 4 + 1 + 2 + 3)|";//5❌-25
    program += "local int temp7 <= 1+(2+1)+5+7+8|";//24✅
    program += "local int temp8 <= (1 - (2 - (10 + (5 + 5 + 5))) + 5 + 5) |";//34❌14
     */
    //program += "local int tuki <= 10+2|";

    /*
    program += "local int res <= ((1 - 1)+(2+1))|";
    program += "local int res1 <= 1 + ((5 + (1 - 3)) + 2) - 1|";
    program += "local int res2 <= 5 + (1 - 3) + 2|";
    program += "local int res3 <= 3 - ((res - 1) + 23 + res1 ** res * 5) * -1 + 4|";
    program += "local int res4 <= 3 - (res1+2 + 23 + res1 ** res1 * 5) + 1 + 4|";
    program += "local int res11 <= 3+2+11+1+res|";
     */

    program += "return 1|}";

    Integer resultado = (Integer) testHelper(program).value;
  }
}