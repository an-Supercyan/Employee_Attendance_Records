import com.employee_records.dao.AttendanceService;
import com.employee_records.dao.impl.AttendanceServiceImpl;
import com.employee_records.pojo.dto.AttendanceDTO;
import com.employee_records.pojo.vo.AttendanceVO;
import org.junit.Ignore;
import org.junit.Test;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.List;

public class AtdanSqlTest {

    /**
     * 添加考勤信息
     */
    @Test
    public void addAttendanceTest(){
        AttendanceService attendanceService = new AttendanceServiceImpl();
        AttendanceDTO attendanceDTO = new AttendanceDTO();
        attendanceDTO.setEmployeeName("太史慈");
        attendanceDTO.setDepartment("兵部");
        attendanceDTO.setRequiredHours(8);
        attendanceDTO.setPunchTime(LocalDateTime.now().toString());
        attendanceDTO.setTotalHours(8);
        attendanceDTO.setOverTimeHours(0);
        attendanceDTO.setAbsenceCount(0);
        boolean b = attendanceService.addAttendanceInfo(attendanceDTO);
        try {
            List<AttendanceVO> attendanceVOS = attendanceService.selectAttendanceInfo(attendanceDTO);
            for (AttendanceVO attendanceVO : attendanceVOS) {
                System.out.println(attendanceVO.toString());
            }
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 先执行插入再执行删除
     */
    @Ignore @Test
    public void deleteAttendanceTest(){
        AttendanceService attendanceService = new AttendanceServiceImpl();
        AttendanceDTO attendanceDTO = new AttendanceDTO();
        attendanceDTO.setId(1L);
        boolean b = attendanceService.deleteAttendanceInfo(attendanceDTO);
    }

    /**
     * 分页查询测试
     */
    @Test
    public void PageTest(){
        AttendanceService attendanceService = new AttendanceServiceImpl();
        List<AttendanceVO> attendanceVOS = attendanceService.PageAttendanceInfo(1, 10);
        for (AttendanceVO attendanceVO : attendanceVOS) {
            System.out.println(attendanceVO.toString());
        }
    }

    /**
     * 模糊匹配查询
     * @throws ParseException
     */
    @Test
    public void selectAttendance() throws ParseException {
        AttendanceService attendanceService = new AttendanceServiceImpl();
        AttendanceDTO attendanceDTO = new AttendanceDTO();
        attendanceDTO.setEntryTime("2023-10-02-10:00:00");
        List<AttendanceVO> attendanceVOS = attendanceService.selectAttendanceInfo(attendanceDTO);
        for (AttendanceVO attendanceVO : attendanceVOS) {
            System.out.println(attendanceVO.toString());
        }
    }

    /**
     * 更新考勤信息
     */
    @Test
    public void updateAttendance(){
        AttendanceService attendanceService = new AttendanceServiceImpl();
        AttendanceVO attendanceVO = attendanceService.selectAttendanceById(50L);
        System.out.println(attendanceVO.toString());

        AttendanceDTO attendanceDTO = new AttendanceDTO();
        attendanceDTO.setId(attendanceVO.getId());
        attendanceDTO.setEmployeeName("孙伯符");
        attendanceDTO.setDepartment("人事部");
        attendanceDTO.setPunchTime(LocalDateTime.now().toString());
        attendanceDTO.setTotalHours(20);
        attendanceDTO.setAbsenceCount(10);

        boolean b = attendanceService.updateAttendanceInfo(attendanceDTO);
        AttendanceVO attendanceVO1 = attendanceService.selectAttendanceById(50L);
        System.out.println(attendanceVO1.toString());
    }
}
