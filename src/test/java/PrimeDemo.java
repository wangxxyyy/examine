import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/6/9 0009.
 */
public class PrimeDemo {
    BufferedWriter bw = null;
    String filename = "C:/Users/Administrator/workspace/test/test.txt";
    static int s ,p,t;
    static long num;
    boolean isPrime(int n){
        for(int i = 2;i<=n/2;i++){
            if(n % i ==0)
                return false;
        }
        return true;
    }
    void printPrime(int m,int n) throws IOException{
        bw = new BufferedWriter(new FileWriter(filename));
        int j = 0;
        for(int i=0;i<=n;i++){
            if(isPrime(i)){
                j++;
                if(j%t==0){
                    System.out.print("" + i);
                    System.out.print("" + num);
                    System.out.print("");
                    num = num + i;
                    String s = String.valueOf(i);
                    String s1 = s + "";
                    String s2  = String.valueOf(num);
                    bw.write(s1);
                    bw.write(s2);
                    bw.newLine();
                    num = 0;
                }
                else {
                    String s = String.valueOf(i);
                    String s3 = s + "";
                    bw.write(s3);
                    num = num + i;
                    System.out.print("" + i);
                }
            }
        }
        String s4 = String.valueOf(num);
        System.out.print("" + num);
        bw.write(s4);
        bw.flush();
        bw.close();
    }

    public static void main(String[] args) throws IOException{
        PrimeDemo pn = new PrimeDemo();
        int [] arr = new int[10];
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String s1;
        while ((s1=br.readLine())!=null&&s1.length()!=0){
            Pattern p1 = Pattern.compile("(\\d{1,3})");
            Matcher m = p1.matcher(s1);
            int i =0;
            while(m.find()){
                int j = 0;
                j= Integer.parseInt(m.group());
                arr[i] = j;
                i++;
            }
            p = arr[0];
            p = arr[1];
            p = arr[2];
            pn.printPrime(p, s);
        }
    }
}
