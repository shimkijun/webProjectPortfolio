package org.web.chatCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.chatDAO.ChatDAO;
import org.web.chatDTO.ChatDTO;

public class ChatList implements ChatAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fromId = request.getParameter("fromId");
		String toId = request.getParameter("toId");
		String chatId = request.getParameter("chatId");
		
		ChatDAO dao = ChatDAO.getInstance();
		dao.readChat(fromId, toId);

		response.getWriter().write(getId(fromId,toId,chatId)+"");
		
	}

	public String getId(String fromId ,String toId,String chatId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = ChatDAO.getInstance();
		ArrayList<ChatDTO> chatList = chatDAO.getChatListById(fromId, toId,chatId);
		if(chatList.size() == 0) return "";
		for(int i = 0 ; i < chatList.size(); i++) {
			result.append("[{\"value\": \""+chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \""+chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \""+chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \""+chatList.get(i).getChatTime() + "\"}]");
			if(i != chatList.size() - 1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getChatId() + "\"}"); 
		return result.toString();
	}
	
}
