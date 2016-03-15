package bbs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bbs.beans.UserList;
import bbs.service.UserListService;

@WebServlet(urlPatterns = { "/usermanager" })
public class UserManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

				List<UserList> userlists = new UserListService().getUser();

				request.setAttribute("userlists", userlists);
				request.getRequestDispatcher("usermanager.jsp").forward(request, response);
	}



	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		int userId = Integer.parseInt(request.getParameter("userId"));
		int status = Integer.parseInt(request.getParameter("status"));

		new UserListService().update(userId, status);
		response.sendRedirect("usermanager");
	}

}
