import com.employee_records.dao.AttendanceService;
import com.employee_records.dao.UserService;
import com.employee_records.dao.impl.AttendanceServiceImpl;
import com.employee_records.dao.impl.LogoutServiceImpl;
import com.employee_records.dao.impl.RegisterServiceImpl;
import com.employee_records.dao.impl.UserServiceImpl;
import com.employee_records.pojo.dto.AttendanceDTO;
import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.entity.User;
import com.employee_records.pojo.vo.AttendanceVO;
import org.junit.Ignore;
import org.junit.Test;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.List;

public class UserSQLTest {
        @Test
        public void addUserTest() {
            UserServiceImpl userService = new UserServiceImpl();
            User user = new User();
            user.setUserName("test");
            user.setPassWord("123456");
            user.setAuthId(0L);
            userService.addUser(user);
        }
        @Test
        public void deleteUserTest(){
            LogoutServiceImpl logoutService = new LogoutServiceImpl();
            RegisterServiceImpl registerService = new RegisterServiceImpl();
            User user = new User();
            user.setId(3);
            logoutService.deleteUserById(user.getId());
            System.out.println(user);
        }

        @Test
        public void getUserByNameTest(){
            UserService userService = new UserServiceImpl();
            User user = userService.getUserByName("test");
            System.out.println(user);
        }
    }

