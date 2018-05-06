import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by Administrator on 2017/6/9 0009.
 */
public class MapTest {
    public static void main(String[] args) {
        TreeMap<Integer,Student> map = new TreeMap<>();
        int total = 0;
        int [] grade = new int[5];
        Student [] s = new Student[5];
        s[0] = new Student(150001,"王军",85,75,95);
        s[1] = new Student(150002,"李计",90,70,80);
        s[2] = new Student(150003,"严红",92,80,80);
        s[3] = new Student(150004,"马莉",80,87,76);
        s[4] = new Student(150005,"刘燕",80,70,60);
        map.put(150001,s[0]);
        map.put(150002,s[1]);
        map.put(150003,s[2]);
        map.put(150004,s[3]);
        map.put(150005,s[4]);
        int[] arr = new int[5];
        int i =0;
        int j = Integer.parseInt(args[0]);
        System.out.print("学号  姓名  计算机成绩   数学成绩  英语成绩   总学分");
        if(map.containsKey(j)){
            System.out.print("你要查找的学生信息是: ");
            Student stu = map.get(j);
            System.out.print(stu.id + "  ");
            System.out.print(stu.name + "  ");
            System.out.print(stu.computer_score + "  ");
            System.out.print(stu.english_score + "  ");
            System.out.print(stu.math_score + "  ");
            total = stu.computer_score + stu.english_score + stu.math_score;
            System.out.print(total);
        }
        System.out.print("");
        TreeMap<Integer,Student> tp = new TreeMap<>();
        Iterator<Map.Entry<Integer,Student>> it = map.entrySet().iterator();
        System.out.print("按照总学分排序前");
        while (it.hasNext()){
            Map.Entry entry = it.next();
            arr[i] = (Integer) entry.getKey();
            s[i] = (Student) entry.getValue();
            System.out.print(s[i].id + "  ");
            System.out.print(s[i].name + "  ");
            System.out.print(s[i].computer_score + "  ");
            System.out.print(s[i].english_score + "  ");
            System.out.print(s[i].math_score + "  ");
            total = s[i].computer_score + s[i].english_score + s[i].math_score;
            System.out.print(total);
            System.out.print("");
            grade[i] = total;
            System.out.print("");
            tp.put(grade[i],s[i]);
            i++;
        }
        i=0;
        System.out.print("按照总学分排序后");
        Iterator<Map.Entry<Integer,Student>> iter = tp.entrySet().iterator();
        while(iter.hasNext()){
            Map.Entry entry1 = iter.next();
            arr[i] = (Integer) entry1.getKey();
            s[i] = (Student) entry1.getValue();
            System.out.print(s[i].id + " ");
            System.out.print(s[i].name + " ");
            System.out.print(s[i].computer_score + " ");
            System.out.print(s[i].english_score + " ");
            System.out.print(s[i].math_score + " ");
            total = s[i].computer_score + s[i].english_score + s[i].math_score;
            System.out.print(total);
            System.out.print(" ");
        }
    }

    static class Student{
        public int id;
        public  String name;
        public int math_score;
        public int english_score;
        public int computer_score;
        public Student(int id,String name,int math_score,int english_score,int computer_score){
            this.id = id;
            this.name = name;
            this.math_score = math_score;
            this.english_score = english_score;
            this.computer_score = computer_score;
        }
    }
}
