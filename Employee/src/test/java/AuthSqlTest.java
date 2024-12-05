import com.employee_records.dao.LogoutService;
import com.employee_records.dao.RegisterService;
import com.employee_records.dao.impl.LogoutServiceImpl;
import com.employee_records.dao.impl.RegisterServiceImpl;
import com.employee_records.pojo.dto.AuthenticationDTO;
import com.employee_records.pojo.vo.AuthenticationVO;
import org.junit.Test;

public class AuthSqlTest {

    /**
     * 更新权限信息
     */
    @Test
    public void updateAuthTest(){
        AuthenticationDTO authenticationDTO = new AuthenticationDTO(10L,10L);
        RegisterService registerService = new RegisterServiceImpl();
        AuthenticationVO auth = registerService.getAuthByKey("secret7");

        System.out.println(auth);
        registerService.updateAuth(authenticationDTO);
        System.out.println(registerService.getAuthByKey("secret7"));
    }

    /**
     * 删除权限信息
     */
    @Test
    public void deleteAuthTest() {
        LogoutService logoutService = new LogoutServiceImpl();
        RegisterService registerService = new RegisterServiceImpl();
        AuthenticationVO auth = registerService.getAuthByKey("secret6");

        System.out.println(auth);
        logoutService.deleteAuthById(9L);
        System.out.println(registerService.getAuthByKey("secret6"));
    }
}
