package bbs.dao;

import static bbs.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bbs.beans.Comment;
import bbs.exception.SQLRuntimeException;

public class CommentDao {

	public void insert(Connection connection, Comment comment) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO comments (");
			sql.append("user_id");
			sql.append(", message_id");
			sql.append(", text");
			sql.append(", insert_date");
			sql.append(") VALUES (");
			sql.append(" ?");
			sql.append(", ?");
			sql.append(", ?");
			sql.append(", CURRENT_TIMESTAMP");
			sql.append(")");

			ps = connection.prepareStatement(sql.toString());

			ps.setInt(1, comment.getUserId());
			ps.setInt(2, comment.getMessageId());
			ps.setString(3, comment.getText());

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}


	public void deleteComment(Connection connection, int id) {

		PreparedStatement ps = null;
		try {
			String sql = "DELETE FROM comments WHERE (id = ?)";

			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);

			ps.executeUpdate();

		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

}
