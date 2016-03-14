package bbs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import bbs.beans.CategoryList;
import bbs.beans.Comment;
import bbs.beans.InsertDateList;
import bbs.beans.User;
import bbs.beans.UserComment;
import bbs.beans.UserMessage;
import bbs.service.CommentService;
import bbs.service.MessageService;

@WebServlet(urlPatterns = { "/home" })
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		User user = (User) request.getSession().getAttribute("loginUser");

		List<UserMessage> messages = null;
		InsertDateList insertDate = new InsertDateList();

		String dateFrom = request.getParameter("insert_from");
		String dateTo = request.getParameter("insert_to");

		if(StringUtils.isEmpty(dateFrom)) {
			new MessageService().getDateFrom(insertDate);
		} else {
				insertDate.setFrom(dateFrom);
		}

		if(StringUtils.isEmpty(dateFrom)) {
			new MessageService().getDateFrom(insertDate);
		} else {
				insertDate.setFrom(dateFrom);
		}

		if (StringUtils.isEmpty(dateTo)) {
			new MessageService().getDateTo(insertDate);
		} else {
				insertDate.setTo(dateTo);
		}

		String category = request.getParameter("category");

		if(!StringUtils.isEmpty(category)) {
			messages = new MessageService().getMessage(category, insertDate);
		} else {
			messages = new MessageService().getMessage(insertDate);
		}

			List<UserComment>comments = new CommentService().getComment();
			List<CategoryList>categories = new MessageService().getCategory();

			request.setAttribute("messages", messages);
			request.setAttribute("comments", comments);
			request.setAttribute("categories", categories);

			int branch_id = user.getBranch_id();
			int department_id = user.getDepartment_id();

			request.setAttribute("branch_id", branch_id);
			request.setAttribute("department_id", department_id);

			request.getRequestDispatcher("top.jsp").forward(request, response);
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession();
		List<String> messages = new ArrayList<String>();

		User user = (User) request.getSession().getAttribute("loginUser");

		Comment comment = new Comment();
		comment.setUser_id(user.getId());
		comment.setMessage_id(Integer.parseInt(request.getParameter("message_id")));
		comment.setText(request.getParameter("text"));

		if(isValid(request, messages) == true) {

			new CommentService().register(comment);
			response.sendRedirect("home");
		} else {
			session.setAttribute("errorMessages", messages);

			request.setAttribute("inputData", comment);
			response.sendRedirect("home");
		}
	}


	private boolean isValid(HttpServletRequest request, List<String> messages) {

		String text = request.getParameter("text");

		if(StringUtils.isEmpty(text)) {
			messages.add("コメントは500文字以下で入力してください。");
		}
		if(StringUtils.isNotEmpty(text) && 500 < text.length()) {
			messages.add("aaaaコメントは500文字以下で入力してください。");
		}
		if(messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}
