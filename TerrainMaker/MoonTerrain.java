import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;


public class MoonTerrain {

    private int n = 5;
    private int last = (int) Math.pow(2, n) + 1;
    private float[][] a = new float[last][last];
    private float A = 10;
    private float R = 0;
    private float H = 2;
    private int min = -1;
    private int max = 1;
    private void m() throws FileNotFoundException {

        a[0][0] = 20;
        a[0][last - 1] = 20;
        a[last - 1][0] = 5;
        a[last - 1][last - 1] = 2;

        Position top_left = new Position(0, 0);
        Position top_right = new Position(0, last - 1);
        Position bottom_left = new Position(last - 1, 0);
        Position bottom_right = new Position(last - 1, last - 1);

        interpolate(last + 1, top_left, top_right, bottom_left, bottom_right);

        PrintStream stream = new PrintStream(new FileOutputStream("file.txt"));

        System.out.println(last);
        for (int i = 0; i < last; i++) {
            for (int j = 0; j < last; j++) {
                stream.print(a[i][j] + " ");
            }
            stream.println();
        }

        Scanner scanner = new Scanner(new File("matriz.txt"));

        for (int i = 0; i < last; i++){
            for (int j = 0; j < last; j++){
                a[i][j] = scanner.nextFloat();
            }
        }

        triangles();
    }

    private void interpolate(int n, Position top_left, Position top_right, Position bottom_left, Position bottom_right){
        if(n < 2) return;
        int mid_x = (top_left.i + bottom_left.i + 1) / 2;
        int mid_y = (top_left.j + top_right.j + 1) / 2;
        make_interpoalation(n,mid_x, mid_y, top_left, top_right, bottom_left, bottom_right);
        n = n / 2;
        interpolate(n, new Position(top_left.i, top_left.j), new Position(top_left.i, mid_y), new Position(mid_x, top_left.j), new Position(mid_x, mid_y));
        interpolate(n, new Position(top_right.i, mid_y), new Position(top_right.i, top_right.j), new Position(mid_x,mid_y), new Position(mid_x, bottom_right.j));
        interpolate(n, new Position(mid_x, top_left.j), new Position(mid_x, mid_y), new Position(bottom_left.i, bottom_left.j), new Position(bottom_left.i, mid_y));
        interpolate(n, new Position(mid_x, mid_y), new Position(mid_x, bottom_right.j), new Position(bottom_right.i, mid_y), new Position(bottom_right.i, bottom_right.j));
    }

    private void make_interpoalation(int n,int mid_x, int mid_y, Position top_left, Position top_right, Position bottom_left, Position bottom_right) {
        float R = getRandom();
        float noise = (float) (A * R * Math.pow(2, -1 * H * n));
        a[top_left.i][mid_y] = (0.5f) * (a[top_left.i][top_left.j] + a[top_right.i][top_right.j]) + noise;
        a[bottom_left.i][mid_y] = (0.5f) * (a[bottom_left.i][bottom_left.j] + a[bottom_right.i][bottom_right.j]) + noise;
        a[mid_x][top_left.j] = (0.5f) * (a[top_left.i][top_left.j] + a[bottom_left.i][bottom_left.j]) + noise;
        a[mid_x][top_right.j] = (0.5f) * (a[top_right.i][top_right.j] + a[bottom_right.i][bottom_right.j]) + noise;
        a[mid_x][mid_y] = (0.25f) * (a[top_left.i][mid_y] + a[bottom_left.i][mid_y] + a[mid_x][top_left.j] + a[mid_x][top_right.j]) + noise;
    }
    private float getRandom(){
        return ThreadLocalRandom.current().nextFloat() * 2 - 1;
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
        new MoonTerrain().m();
    }


}
