/**
 * Clase principal de la aplicación que implementa un simple calculador con capacidad para leer desde un archivo o la entrada estándar.
 */
package com.compi;

import java_cup.runtime.Symbol;
import picocli.CommandLine;
import picocli.CommandLine.Command;
import picocli.CommandLine.Option;

import java.io.File;
import java.io.FileReader;
import java.io.Reader;
import java.io.StringReader;
import java.nio.file.Files;
import java.util.Scanner;
import java.util.concurrent.Callable;

import utilidades.Archivos;

/**
 * Clase principal de la aplicación con anotaciones de Picocli para la gestión de comandos.
 */
@Command(name = "lexer", mixinStandardHelpOptions = true, version = "0.1",
        description = "Analizador léxico")
public class App implements Callable<Integer> {

    @Option(names = {"-f", "--file"}, description = "File to read")
    File file;

    /**
     * Método principal que se ejecuta al llamar a la aplicación.
     * @return Código de salida.
     * @throws Exception Excepción general que podría ocurrir durante la ejecución.
     */
    @Override
    public Integer call() throws Exception {
        if (file != null) {
            // Leer desde el archivo si se proporciona
            try (Reader reader = Files.newBufferedReader(file.toPath())) {
                parseAndPrintTokens(reader, file.getName());
                parsear(file.getAbsolutePath());
            }
        } else {
            // Leer desde la entrada estándar
            Scanner scanner = new Scanner(System.in);
            String input = "";
            
            while (true) {
                System.out.print("Path: ");
                input = scanner.nextLine();
                File inputFile = new File(input);
                
                if (input.equals("exit")) {
                    break;
                }
                else if (inputFile.exists()) {
                    try (Reader reader = Files.newBufferedReader(inputFile.toPath())) {
                        parseAndPrintTokens(reader, input);
                        parsear(input);
                    }
                } else {
                    System.out.println("Archivo no encontrado.");
                }
            }
        }
        return 0;
    }

    /**
     * Método privado que parsea el archivo de entrada y muestra el resultado.
     * @param reader
     * @param filename
     * @throws Exception
     */
    private void parsear(String filename) throws Exception {
        IdLexer lexer = new IdLexer(new FileReader(filename));
        Parser p = new Parser(lexer);
        p.parse();
        System.out.println("¡¡¡Se puede compilar!!! 😀");
    }

    /**
     * Método privado que realiza el análisis léxico y muestra los tokens obtenidos.
     * @param reader Objeto Reader para leer el contenido del archivo.
     * @param filename Es el nombre del archivos del que se obtuvo el reader.
     * @throws Exception Excepción general que podría ocurrir durante el análisis.
     */
    private void parseAndPrintTokens(Reader reader, String filename) throws Exception {
        // Crea un lexer y un parser
        IdLexer lexer = new IdLexer(reader);
        Parser parser = new Parser(lexer);
        String format = "%-20s %-15s %-15s %-15s\n";
        String content = String.format(format, "Tipo", "Linea", "Columna", "Lexema");
        String newPath = "./resultados/" + filename.substring(0, filename.indexOf(".")) + "/";
        String resFile = newPath + filename.substring(0, filename.indexOf(".")) + ".txt";

        Symbol token;
        int count = 0;
        
        while (true) {
            // Obtiene el siguiente token del lexer
            token = lexer.next_token();
            if (token.sym == 0) {
                break;
            }

            // Extrae información del token
            int idToken = token.sym;
            String value = token.value.toString();
            int line = token.left + 1;
            int column = token.right + 1;
            
            content += String.format(format, ParserSym.terminalNames[idToken], line, column, value);

            count++;
        }
        
        content += "Total: " + count + " tokens.";
        
        Archivos.newFolder(newPath);
        Archivos.crearArchivo(resFile);
        Archivos.escribirArchivo(resFile, content);
        System.out.println(content);
    }

    /**
     * Método principal de la aplicación que instancia la clase App y ejecuta la aplicación mediante Picocli.
     * @param args Argumentos de la línea de comandos.
     */
    public static void main(String[] args) {
        // Ejecuta la aplicación
        int exitCode = new CommandLine(new App()).execute(args);
        System.exit(exitCode);
    }
}
