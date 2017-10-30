import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;


public class Triangle_Maker {

    private int n = 5;
    private int last = (int) Math.pow(2, n) + 1;
    private float[][] a = new float[last][last];
    
    private void m() throws FileNotFoundException {

        Scanner scanner = new Scanner(new File("matriz.txt"));

        for (int i = 0; i < last; i++){
            for (int j = 0; j < last; j++){
                a[i][j] = scanner.nextFloat();
            }
        }

        triangles();
    }

    private void triangles() throws FileNotFoundException {
        PrintStream stream = new PrintStream(new FileOutputStream("file.txt"));
        

        stream.println("mesh {");

        for (int i = 0; i < last - 1; i++){
            for (int j = 0; j < last - 1; j++){
                stream.println("triangle {");
                stream.printf("<%d, %f, %d><%d, %f, %d><%d, %f, %d>\n", i, a[i][j], j, i, a[i][j + 1], j + 1, i + 1, a[i + 1][j + 1], j + 1);
                stream.println("texture { T_Water } ");
                stream.println("}");

                stream.println("triangle {");
                stream.printf("<%d, %f, %d><%d, %f, %d><%d, %f, %d>\n", i + 1, a[i + 1][j + 1], j + 1, i + 1, a[i + 1][j], j, i, a[i][j], j);
                stream.println("texture { T_Water } ");
                stream.println("}");
            }
        }

        stream.println("}");
    }

    public static void main(String[] args) throws FileNotFoundException {
        new Triangle_Maker().m();
    }


}
