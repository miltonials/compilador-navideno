package com.compi;

import java_cup.runtime.Symbol;
import picocli.CommandLine;

import java.io.File;
import java.io.Reader;
import java.nio.file.Files;
import java.util.Scanner;
import java.util.concurrent.Callable;

import static picocli.CommandLine.*;

@Command(name = "calc", mixinStandardHelpOptions = true, version = "0.0.1",
        description = "Simple Calculator")
public class App implements Callable<Integer> {

    @Option(names = {"-f", "--file"}, description = "File to read")
    File file;

    @Override
    public Integer call() throws Exception {
        if (file != null) {
            // Leer desde el archivo si se proporciona
            try (Reader reader = Files.newBufferedReader(file.toPath())) {
                parseAndPrintTokens(reader);
            }
        } else {
            // Leer desde la entrada estándar
            Scanner scanner = new Scanner(System.in);
            System.out.print("Path: ");
            String input = scanner.nextLine();
            //String input = "miPrograma.txt";

            if (input.equalsIgnoreCase("exit")) {
                return 0;
            }

            File inputFile = new File(input);
            if (inputFile.exists()) {
                try (Reader reader = Files.newBufferedReader(inputFile.toPath())) {
                    parseAndPrintTokens(reader);
                }
            } else {
                System.out.println("File not found.");
            }
        }
        return 0;
    }

    private void parseAndPrintTokens(Reader reader) throws Exception {
        // Crea un lexer y un parser
        IdLexer lexer = new IdLexer(reader);
        Parser parser = new Parser(lexer);

        Symbol token;
        int count = 0;

        // Imprime encabezado
        System.out.printf("\n%-15s %-15s %-15s %-15s\n", "Tipo", "Lexema", "Linea", "Columna");
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

            // Imprime de forma legible
            System.out.printf("%-15s %-15s %-15s %-15s\n", ParserSym.terminalNames[idToken], value, line, column);

            count++;
        }
        System.out.println("Total: " + count + " tokens.");
    }

    public static void main(String[] args) {
        // Ejecuta la aplicación
        int exitCode = new CommandLine(new App()).execute(args);
        System.exit(exitCode);
    }
}
