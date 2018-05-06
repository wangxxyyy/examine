/**
 * Created by Administrator on 2018/3/1 0001.
 */
public class Sorts {
        public  void smallAndBig(){
            int arrs[] = {3, 5, 9, 7, 4, 13, 15, 0, 2, 20};
            for (int i = 1; i < arrs.length; i++) {
                for (int j = 0; j < arrs.length - 1; j++) {
                    if (arrs[j] > arrs[j + 1]) {
                        int temp;
                        temp = arrs[j];
                        arrs[j] = arrs[j + 1];
                        arrs[j + 1] = temp;
                    }
                }
            }
            for (int i = 0; i < arrs.length; i++) {
                System.out.println(" " + arrs[i] + "");
            }
        }

        public static void main(String [] args){
            Sorts sorts = new Sorts();
            sorts.smallAndBig();
        }
 }
