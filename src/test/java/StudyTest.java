import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2017/6/8 0008.
 */
public class StudyTest {
    public static void main(String[] args) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String time = df.format(new Date());
        System.out.print(time);
    }
}

