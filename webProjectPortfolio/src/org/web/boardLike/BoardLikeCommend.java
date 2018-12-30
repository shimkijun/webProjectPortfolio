package org.web.boardLike;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface BoardLikeCommend {

	void excuteAction(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException;

}
