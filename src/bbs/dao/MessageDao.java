package bbs.dao;

import static bbs.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bbs.beans.Message;
import bbs.beans.UserComment;
import bbs.exception.SQLRuntimeException;



public class MessageDao {

	public void insert(Connection connection, Message message) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO messages (");
			sql.append("user_id");
			sql.append(", title");
			sql.append(", text");
			sql.append(", category");
			sql.append(", insert_date");
			sql.append(") VALUES (");
			sql.append(" ?");
			sql.append(", ?");
			sql.append(", ?");
			sql.append(", ?");
			sql.append(", CURRENT_TIMESTAMP");
			sql.append(")");

			ps = connection.prepareStatement(sql.toString());

			ps.setInt(1, message.getUserId());
			ps.setString(2, message.getTitle());
			ps.setString(3, message.getText());
			ps.setString(4, message.getCategory());

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}


	public void deleteMessage(Connection connection, int id) {

		PreparedStatement ps = null;
		try {
			String sql = "DELETE FROM messages WHERE (id = ?)";

			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);

			ps.executeUpdate();

		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}


	public List<UserComment> getCommentId(Connection connection, int messageId) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT id  FROM user_comment ");
			sql.append("WHERE message_id = ?");

			ps = connection.prepareStatement(sql.toString());
			ps.setInt(1, messageId);

			ResultSet rs = ps.executeQuery();
			List<UserComment> ret = toCommentId(rs);

			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}


	private List<UserComment> toCommentId(ResultSet rs) throws SQLException {

		List<UserComment> ret = new ArrayList<UserComment>();
		try {
			while(rs.next()) {
				int id = rs.getInt("id");

				UserComment commentId = new UserComment();
				commentId.setMessageId(id);

				ret.add(commentId);
			}
			return ret;
		} finally {
			close(rs);
		}
	}

}
