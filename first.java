import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;


public class first {
    public static void main(String[] args) throws Exception {
        // Compiler Flags
        String compiler = "javac";
        String options = "-Xlint:none";
        String outputPath = "test";
        String preprocPath = "libs/lombok-1.18.38.jar";
        String classPath = "";
        String input = "srcinput.txt";

        // Build classPath
        File dir1 = new File("libs/");
        classPath = traverseDir(dir1);
        classPath += ";" + outputPath;

        /* Prepare Sources To Compile */
        // Create Source File (if not exists)
        File fp = new File(input);
        if (!fp.exists()) {
            fp.createNewFile();
            System.out.println("New file created successfully.");
        } else {
            try (PrintWriter pw = new PrintWriter(fp.getAbsolutePath())) { }
            catch (IOException e) { e.printStackTrace(); }
            System.out.println("File already exists. Hence, file contents erased! (to be written in future)");
        }
        // Traverse and write paths to srcinput.txt
        File dir2 = new File("src/main/java/org/cloudsimplus/");
        File currDir = new File(".");
        traverseDirRec(dir2, fp, currDir);
        System.out.println(input + ": ");


        // Build the Final Command
        // Successfully Compiled All Files
        ProcessBuilder pb = new ProcessBuilder(
                                               compiler, options,
                                               "-cp", classPath,
                                               "-d", outputPath,
                                               "--processor-path", preprocPath,
                                               "@" + input
                                               );
        pb.inheritIO().start().waitFor();

        // Runa a particular example
        String runTime = "java";
        String exFile = "samples/org/cloudsimplus/examples/LoggingExample.java";
        ProcessBuilder run = new ProcessBuilder(runTime, "-cp", classPath, exFile);
        run.inheritIO().start().waitFor();
    }

    public static void traverseDirRec(File dir, File ans, File workDir) {
        try (FileWriter writer = new FileWriter(ans, true)){
            traverseDirHelper(dir, writer, workDir);
        } catch (IOException e) {
            System.err.println("IO Error occurred");
            e.printStackTrace();
        }
    }

    private static void traverseDirHelper(File dir, FileWriter writer, File workDir) throws IOException {
        File[] files = dir.listFiles();
        if (files == null) return;
        for (File f : files) {
            if (!f.isDirectory()) {
                Path dirPath = Paths.get(workDir.getAbsolutePath());
                Path filePath = Paths.get(f.getAbsolutePath());
                Path relativePath = dirPath.relativize(filePath);
                writer.write(relativePath.toString() + "\n");
            } else {
                traverseDirHelper(f, writer, workDir);
            }
        }
    }

    public static String traverseDir(File dir) {
        File[] jars = dir.listFiles();
        if (jars == null) return "";

        StringBuilder sb = new StringBuilder();
        boolean first = true;
        for (File f : jars) {
            if (f.toString().endsWith(".bak")) continue;
            if (!first) sb.append(";");
            sb.append(f);
            first = false;
        }
        return sb.toString();
    }

///////////////////////////////////////////////////
    class Util {
        static void println(Object... args) {
            for (Object arg : args) {
                System.out.println(arg);
            }
        }
    }


}
