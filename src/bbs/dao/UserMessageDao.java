package bbs.dao;

import static bbs.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bbs.beans.InsertDateList;
import bbs.beans.UserMessage;
import bbs.exception.SQLRuntimeException;

public class UserMessageDao {

	public List<UserMessage> getUserMessages(Connection connection, InsertDateList insertDate) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM user_message WHERE insert_date > ? && insert_date <= ? ");
			sql.append("ORDER BY insert_date DESC");

			ps = connection.prepareStatement(sql.toString());
			ps.setString(1, insertDate.getFrom() + " 00:00");
			ps.setString(2, insertDate.getTo() + " 23:59");

			ResultSet rs = ps.executeQuery();

			List<UserMessage> ret = toUserMessageList(rs);

			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	private List<UserMessage> toUserMessageList(ResultSet rs) throws SQLException {

		List<UserMessage> ret = new ArrayList<UserMessage>();
		try {
			while(rs.next()) {
				int message_id = rs.getInt("message_id");
				String title = rs.getString("title");
				String text = rs.getString("text");
				String name = rs.getString("name");
				String category = rs.getString("category");
				int branch_id = rs.getInt("branch_id");
				Timestamp insertDate = rs.getTimestamp("insert_date");

				UserMessage message = new UserMessage();
				message.setMessage_id(message_id);
				message.setTitle(title);
				message.setText(text);
				message.setName(name);
				message.setCategory(category);
				message.setBranch_id(branch_id);
				message.setInsertDate(insertDate);

				ret.add(message);
			}
			return ret;
		} finally {
			close(rs);
		}
	}


	public List<UserMessage> getMessages(Connection connection, String category, InsertDateList insertDate) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM user_message WHERE category = ? && insert_date > ? && insert_date <= ? ");
			sql.append("ORDER BY insert_date DESC");

			ps = connection.prepareStatement(sql.toString());
			ps.setString(1, category);
			ps.setString(2, insertDate.getFrom() + " 00:00");
			ps.setString(3, insertDate.getTo() + " 23:59");

			ResultSet rs = ps.executeQuery();
			List<UserMessage> ret = toUserMessageList(rs);

			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

}
