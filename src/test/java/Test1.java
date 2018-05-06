/**
 * Created by Administrator on 2017/6/8 0008.
 */
public class Test1 {
   /* private static void test(int[]arr) {
        for (int i = 0; i < arr.length; i++) {
            try {
                if (arr[i] % 2 == 0) {
                    throw new NullPointerException();
                } else {
                    System.out.print(i);
                }
            } finally {
                System.out.print("e");
            }
        }
    }*/
    public static void main(String[] args) {
            String str = "abcdefg";
            StringBuffer stringBuffer = new StringBuffer (str);
            String reverseStr = stringBuffer.reverse().toString();
            System.out.print(reverseStr);
        }
    }
