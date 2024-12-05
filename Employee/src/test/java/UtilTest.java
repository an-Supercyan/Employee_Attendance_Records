import com.employee_records.pojo.vo.AttendanceVO;
import com.employee_records.util.Date4matter;
import com.employee_records.util.Druid;
import org.junit.Test;

import java.sql.Connection;
import java.time.LocalDateTime;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class UtilTest {

    /**
     * durid 连接池测试
     */
    @Test
    public void getConncetionTest(){
        Connection connection = Druid.getConnection();
        if(connection==null){
            fail();
        }else{
            System.out.println("success");
            assertTrue(true);
        }
    }

    /**
     * BeanUtils测试
     */
    @Test
    public void BeanUtilsTest(){
        AttendanceVO attendanceVO = new AttendanceVO();
        attendanceVO.setEmployeeName("zhangsan");
        attendanceVO.setId(1L);
        attendanceVO.setDepartment("IT");
        attendanceVO.setPunchTime(LocalDateTime.now().toString());
        attendanceVO.setTotalHours(8);
        attendanceVO.setOverTimeHours(4);
        attendanceVO.setAbsenceCount(0);
        attendanceVO.setEntryTime("2023-02-22");
    }

    /**
     * 日期格式转化
     */
    @Test
    public void formatDateTest(){
        LocalDateTime date = LocalDateTime.of(2023, 2, 22, 0, 0);
        System.out.println(date);
        System.out.println(Date4matter.formatDate(date));
        System.out.println(Date4matter.formatDateNormal(date));
    }
}
