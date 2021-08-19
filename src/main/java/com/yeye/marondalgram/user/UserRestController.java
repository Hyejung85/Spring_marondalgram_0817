package com.yeye.marondalgram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yeye.marondalgram.user.bo.UserBO;

@RestController
@RequestMapping("/marondalgram/user")
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam(value="loginId", required = false) String loginId
			, @RequestParam(value="password", required = false) String password
			, @RequestParam(value="name", required = false) String name
			, @RequestParam(value="email", required = false) String email){
		
		Map<String, String> result = new HashMap<>();
		int count = userBO.signUp(loginId, password, name, email);
		
		if(count == 1) {
			result.put("result", "success");
		}else {
			result.put("result", "fail");
		}
		
		return result;
	}
}