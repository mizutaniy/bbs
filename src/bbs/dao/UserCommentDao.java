package bbs.dao;

import static bbs.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bbs.beans.UserComment;
import bbs.exception.SQLRuntimeException;

public class UserCommentDao {

	public List<UserComment> getUserComment(Connection connection) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM user_comment ORDER BY insert_date");
			//sql.append("FROM users, comments WHERE users.id = comments.user_id ");
			//sql.append("ORDER BY comments.insert_date");

			ps = connection.prepareStatement(sql.toString());

			ResultSet rs = ps.executeQuery();
			List<UserComment> ret = toUserCommentList(rs);

			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	private List<UserComment> toUserCommentList(ResultSet rs) throws SQLException {

		List<UserComment> ret = new ArrayList<UserComment>();
		try {
			while(rs.next()) {
				int id = rs.getInt("id");
				int messageId = rs.getInt("message_id");
				String text = rs.getString("text");
				String name = rs.getString("name");
				int branchId = rs.getInt("branch_id");
				String branchName = rs.getString("branch_name");
				String departmentName = rs.getString("department_name");
				Timestamp insertDate = rs.getTimestamp("insert_date");

				UserComment comment = new UserComment();
				comment.setId(id);
				comment.setMessageId(messageId);
				comment.setText(text);
				comment.setName(name);
				comment.setBranchId(branchId);
				comment.setBranchName(branchName);
				comment.setDepartmentName(departmentName);
				comment.setInsertDate(insertDate);

				ret.add(comment);
			}
			return ret;
		} finally {
			close(rs);
		}
	}

}
