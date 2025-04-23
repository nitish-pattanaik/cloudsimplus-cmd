package org.cloudsimplus.examples;

class Util {
    public static void println(Object obj) { System.out.println(obj); }
    public static void print(Object obj) { System.out.print(obj); }
    public static void printf(String format, Object... obj) { println(String.format(format, obj)); }
}

public class ExpOne {
    public static void main(String[] args) {
        Util.println("Nitish");
        for (int i = 0; i < args.length; i++) {
            Util.println("args[" + i + "]: " + args[i]); //normal string
            Util.println(STR."args[\{i}]: \{args[i]}"); //string templates(interpolation)
            Util.printf("args[%d]: %s\n", i, args[i]); //Format String
        }
    }
}
