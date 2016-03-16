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
import bbs.exception.NoRowsUpdatedRuntimeException;
import bbs.service.BranchDepartmentService;
import bbs.service.UserListService;
import bbs.utils.CipherUtil;

@WebServlet(urlPatterns = { "/edituser" })
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession();
		List<String> messages = new ArrayList<String>();

		String userId = request.getParameter("userId");

		if (userId != null && userId.matches("^\\d{1,9}$")) {
			User editUser = new UserListService().getSelectUser(Integer.parseInt(userId));
			if(editUser != null) {

				List<BranchList> branchList = new BranchDepartmentService().getBranchList();
				List<DepartmentList> departmentList = new BranchDepartmentService().getDepartmentList();

				request.setAttribute("branchList", branchList);
				request.setAttribute("departmentList", departmentList);
				request.setAttribute("editUser", editUser);
				request.getRequestDispatcher("edituser.jsp").forward(request, response);
				return;
			}
		}
		messages.add("編集するユーザーを選択してください。");
		session.setAttribute("errorMessages", messages);
		response.sendRedirect("usermanager");
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession();
		List<String> messages = new ArrayList<String>();

		String presentLoginId = request.getParameter("presentLoginId");
		String presentName = request.getParameter("presentName");
		request.setAttribute("presentLoginId", presentLoginId);
		request.setAttribute("presentName",presentName);

		User user = new User();
		user.setId(Integer.parseInt(request.getParameter("id")));
		user.setLoginId(request.getParameter("loginId"));

		if(StringUtils.isEmpty(request.getParameter("password"))) {
			user.setPassword(request.getParameter("presentPassword"));
		} else {
			String encPassword = CipherUtil.encrypt(request.getParameter("password"));
			user.setPassword(encPassword);
		}

		user.setName(request.getParameter("name"));
		user.setBranchId(Integer.parseInt(request.getParameter("branchId")));
		user.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));

		if(isValid(request, messages) == true) {

			try {
				new UserListService().update(user);
				response.sendRedirect("usermanager");

			} catch (NoRowsUpdatedRuntimeException e) {
				session.removeAttribute("editUser");
				messages.add("他の人によって更新されています。最新のデータを表示しました。データを確認してください。");
				session.setAttribute("errorMessages", messages);
				response.sendRedirect("settings");
			}
		} else {
			List<BranchList> branchList = new BranchDepartmentService().getBranchList();
			List<DepartmentList> departmentList = new BranchDepartmentService().getDepartmentList();

			request.setAttribute("branchList", branchList);
			request.setAttribute("departmentList", departmentList);
			session.setAttribute("errorMessages", messages);
			request.setAttribute("editUser", user);
			request.getRequestDispatcher("edituser.jsp").forward(request, response);
		}
	}


	private boolean isValid(HttpServletRequest request, List<String> messages) {
		int id = Integer.parseInt(request.getParameter("id"));
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

		if(!StringUtils.isEmpty(password) && !password.matches("^[a-zA-Z0-9-/:-@\\[-\\`\\{-\\~]{6,255}$")) {
			messages.add("パスワードは6字以上255字以下の記号を含むすべての半角文字で入力してください。");
		}

		if(!StringUtils.isEmpty(password) && StringUtils.isEmpty(passwordConfirm)) {
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
		if(user != null && id != user.getId()) {
			messages.add("ログインIDがすでに利用されています");
		}
		if(messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}
