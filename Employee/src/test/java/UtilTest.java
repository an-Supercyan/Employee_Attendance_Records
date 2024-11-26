import com.employee_records.pojo.vo.AttendanceVO;
import com.employee_records.util.Druid;
import org.junit.Test;

import java.sql.Connection;
import java.time.LocalDateTime;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class UtilTest {
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
}
