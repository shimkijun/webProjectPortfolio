package org.web.adminCommend;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface AdminAction {

	void excuteAction (HttpServletRequest request , HttpServletResponse response) throws ServletException,IOException;
	
}
