/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Book;
import model.Title;

/**
 *
 * @author MSI
 */
public class BookDAO extends BaseDAO {

    public void addBook(String author, String title, int condition, int quantity) {
        int tid = getTidByTitleAuthor(title, author);
        if (tid == -1) {
            addTitle(title, author);
            tid = getTidByTitleAuthor(title, author);
        }
        String sql = "insert into book values(0, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, tid);
            st.setInt(2, condition);
            for (int i = 0; i < quantity; i++) {
                st.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getTidByTitleAuthor(String title, String author) {
        String sql = "select tid from title "
                + "where title=? and author=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, author);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt("tid");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void addTitle(String title, String author) {
        String sql = "insert into title values "
                + "(?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, author);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Title> search(String title, String author) {
        ArrayList<Title> titles = new ArrayList<>();
        try {
            String sql = "SELECT tid, title, author FROM title "
                    + "WHERE (1=1) ";
            HashMap<Integer, String> params = new HashMap<>();
            int paramindex = 0;
            if (title != null && !title.equals("")) {
                sql += "AND title like '%'+?+'%' ";
                paramindex++;
                params.put(paramindex, title);
            }
            if (author != null && !author.equals("")) {
                sql += "AND author like '%'+?+'%' ";
                paramindex++;
                params.put(paramindex, author);
            }
            PreparedStatement st = connection.prepareStatement(sql);
            for (Map.Entry<Integer, String> entry : params.entrySet()) {
                Integer key = entry.getKey();
                String value = entry.getValue();
                st.setString(key, value);
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Title t = new Title();
                t.setTid(rs.getInt("tid"));
                t.setAuthor(rs.getString("author"));
                t.setTitle(rs.getString("title"));
                t.setIsAvailable(isTitleAvailable(rs.getInt("tid")));
                titles.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return titles;
    }

    public boolean isTitleAvailable(int tid) {
        String sql = "select count(tid) as c from book where tid=? and status=0";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, tid);
            ResultSet rs = st.executeQuery();
            rs.next();
            return (rs.getInt("c") != 0);
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public ArrayList<Title> getAllTitles() {
        ArrayList<Title> titles = new ArrayList<>();
        String sql = "select tid, title, author from title";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Title t = new Title();
                t.setTid(rs.getInt("tid"));
                t.setTitle(rs.getString("title"));
                t.setAuthor(rs.getString("author"));
                titles.add(t);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return titles;
    }

    public void rentBook(String username, String bid) {
        long due = 30 * 24 * 60 * 60 * 1000L;
        String sql = "insert into [Transaction]([username], [bid], [transactionDate], [dueDate]) "
                + "values (?,?,?,?)";
        String sql2 = "update book set status=1 where bid=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setInt(2, Integer.parseInt(bid));
            long time = System.currentTimeMillis();
            st.setDate(3, new Date(time));
            st.setDate(4, new Date(time + due));
            st.executeUpdate();
            st = connection.prepareStatement(sql2);
            st.setInt(1, Integer.parseInt(bid));
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Book> getRentedBook(String username) {
        ArrayList<Book> books = new ArrayList<>();
        String sql = "SELECT [Transaction].bid, [Title].title, dueDate\n"
                + "FROM Book, Title, [Transaction]\n"
                + "WHERE username=?\n"
                + "AND [Transaction].bid = [Book].bid\n"
                + "AND [Book].tid = [Title].tid\n"
                + "AND [Transaction].status = 0";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Book book = new Book();
                book.setBid(rs.getInt("bid"));
                Title title = new Title();
                title.setTitle(rs.getString("title"));
                book.setTitle(title);
                book.setDueDate(rs.getDate("dueDate"));
                books.add(book);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public void returnBook(String username, String bid, String condition) {
        String sql = "update [transaction] set status=1 "
                + "where username=? and bid=? and status=0";
        String sql2 = "update book set status=0, cid=? where bid=?";
        try {
//            update transaction status to 1
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setInt(2, Integer.parseInt(bid));
            st.executeUpdate();
//            update book status to 0 and condition
            st = connection.prepareStatement(sql2);
            st.setInt(1, Integer.parseInt(condition));
            st.setInt(2, Integer.parseInt(bid));
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
