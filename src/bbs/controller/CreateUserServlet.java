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

import bbs.beans.BranchList;
import bbs.beans.DepartmentList;
import bbs.beans.User;
import bbs.service.BranchDepartmentService;
import bbs.service.UserListService;

@WebServlet(urlPatterns = { "/createuser" })
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		List<BranchList> branchList = new BranchDepartmentService().getBranchList();
		List<DepartmentList> departmentList = new BranchDepartmentService().getDepartmentList();

		request.setAttribute("branchList", branchList);
		request.setAttribute("departmentList", departmentList);

		request.getRequestDispatcher("createuser.jsp").forward(request, response);
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		List<String> messages = new ArrayList<String>();
		HttpSession session = request.getSession();

		User user = new User();
		user.setLoginId(request.getParameter("loginId"));
		user.setPassword(request.getParameter("password"));
		user.setName(request.getParameter("name"));
		user.setBranchId(Integer.parseInt(request.getParameter("branchId")));
		user.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));

		List<BranchList> branchList = new BranchDepartmentService().getBranchList();
		List<DepartmentList> departmentList = new BranchDepartmentService().getDepartmentList();

		request.setAttribute("branchList", branchList);
		request.setAttribute("departmentList", departmentList);

		if(isValid(request, messages) == true) {
			new UserListService().register(user);
			response.sendRedirect("usermanager");
		} else {
			session.setAttribute("errorMessages", messages);
			request.setAttribute("inputData", user);
			request.getRequestDispatcher("createuser.jsp").forward(request, response);
		}
	}

	private boolean isValid(HttpServletRequest request, List<String> messages) {
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");
		String name = request.getParameter("name");
		int branchId = Integer.parseInt(request.getParameter("branchId"));
		int departmentId = Integer.parseInt(request.getParameter("departmentId"));

		if(StringUtils.isEmpty(loginId)) {
			messages.add("ログインIDを入力してください。");
		}
		if(!StringUtils.isEmpty(loginId) && !loginId.matches("^[0-9A-Za-z]{6,20}$")) {
			messages.add("ログインIDは6字以上20字以下の半角英数字で入力してください。");
		}

		if(StringUtils.isEmpty(password)) {
			messages.add("パスワードを入力してください");
		}
		if(!StringUtils.isEmpty(password) && !password.matches("^[a-zA-Z0-9-/:-@\\[-\\`\\{-\\~]{6,255}$")) {
			messages.add("パスワードは6字以上255字以下の記号を含むすべての半角文字で入力してください。");
		}

		if(StringUtils.isEmpty(passwordConfirm)) {
			messages.add("確認用パスワードを入力してください");
		}
		if(!password.equals(passwordConfirm)) {
			messages.add("パスワードと確認用パスワードが違います。");
		}

		if(StringUtils.isEmpty(name)) {
			messages.add("名称を入力してください");
		}
		if(!StringUtils.isEmpty(name) && !name.matches("^.{1,10}$")) {
			messages.add("名称は10字以内で入力してください。");
		}

		if(branchId == 0) {
			messages.add("支店を選択してください");
		}
		if(departmentId == 0) {
			messages.add("部署・役職を選択してください");
		}

		UserListService signupService = new UserListService();
		User user = signupService.duplicateUser(loginId);
		if(user != null) {
			messages.add("ログインIDがすでに利用されています");
		}
		if(messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}
