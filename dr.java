import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Paths;
import java.nio.file.Path;


// Dependency Resolver: Implemented in JAVA
public class dr {
    public static void main(String[] args) throws Exception {
        //         :: https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.38/lombok-1.18.38.jar
        // set "URL=https://repo1.maven.org/maven2/%GROUP_ID:.=/%/%ARTIFACT_ID%/%VERSION%/%ARTIFACT_ID%-%VERSION%.jar"
        String gid = "", aid = "", version = "";
        for (int i = 0; i < args.length; i++) {
            if (args[i].equals("-gid")) gid += args[i+1];
            else if (args[i].equals("-aid")) aid += args[i+1];
            else if (args[i].equals("-v")) version += args[i+1];
        }
        System.out.println("gid: " + gid + " aid: " + aid + " version: " + version);

        gid = gid.replace(".", "/");
        String URL = String.format("https://repo1.maven.org/maven2/%s/%s/%s/%s-%s.jar", gid, aid, version, aid, version);

        Path fileName = Paths.get(String.format("%s-%s.jar", aid, version));

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder().uri(URI.create(URL)).build();
        HttpResponse<Path> response = client.send(request, HttpResponse.BodyHandlers.ofFile(fileName));

        System.out.println("File downloaded to: " + response.body());
    }

}
