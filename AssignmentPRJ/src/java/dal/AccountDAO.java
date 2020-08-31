/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Group;

/**
 *
 * @author MSI
 */
public class AccountDAO extends BaseDAO {

    public Account getUsernameFeature(String username, String password) {
//        neu gid = 0 thi ko co gia tri fname nao dc tra ve, tu do account khong the dang nhap dc
        Account account = new Account();
        ArrayList<String> features = new ArrayList<>();
        String sql = "select distinct username, name, [User].gid, fname \n"
                + "                from [User], [group], Group_Feature, feature\n"
                + "                where [User].[gid]= [group].gid \n"
                + "                and [group].gid = Group_Feature.gid\n"
                + "                and feature.fid = Group_Feature.fid\n"
                + "                and [User].username = ?\n"
                + "                and [User].password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                account.setUsername(rs.getString("username").trim());
                account.setName(rs.getString("name").trim());
                Group g = new Group();
                g.setGid(rs.getInt("gid"));
                account.setGroup(g);
                features.add(rs.getString("fname").trim());
            }
            if (account.getUsername() != null) {
                account.setFeature(features);
                return account;
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public boolean addAccount(String username, String password, int gid, String name, String phoneNo) {
        if (isUsernameExisted(username)){
            return false;
        }
        String sql = "insert into [User] values (?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setInt(3, gid);
            st.setString(4, name);
            st.setString(5, phoneNo);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }

    public boolean isUsernameExisted(String username){
        String sql = "select username from [User] where username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ArrayList<Account> getAllAccount(String username) {
        ArrayList<Account> accounts = new ArrayList<>();
        String sql = "select [username], [gname], [name], [phoneNo] "
                + "from [User], [Group] "
                + "where [User].gid = [Group].gid "
                + "and [username] != ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                Group group = new Group();
                group.setGname(rs.getString("gname"));
                account.setGroup(group);
                account.setName(rs.getString("name"));
                account.setPhoneNo(rs.getString("phoneNo"));
                accounts.add(account);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }

    public void deleteAccount(String username) {
        String sql = "update [user] "
                + "set gid = 0 "
                + "where username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Account getAccountInfo(String username) {
        Account account = new Account();
        String sql = "select [username], [User].[gid], [gname], [name], [phoneNo] "
                + "from [User], [Group] "
                + "where [User].gid = [Group].gid "
                + "and [username] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                account.setUsername(rs.getString("username"));
                Group group = new Group();
                group.setGid(rs.getInt("gid"));
                group.setGname(rs.getString("gname"));
                account.setGroup(group);
                account.setName(rs.getString("name"));
                account.setPhoneNo(rs.getString("phoneNo"));
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Group> getAllGroup(){
        ArrayList<Group> groups = new ArrayList<>();
        String sql = "select gid, gname from [group]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Group group = new Group();
                group.setGid(rs.getInt("gid"));
                group.setGname(rs.getString("gname"));
                groups.add(group);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groups;
    }
    
    public void updateAccount(Account account){
        String sql = "update [user] "
                + "set gid = ?, name=?, phoneNo=? "
                + "where username=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, account.getGroup().getGid());
            st.setString(2, account.getName());
            st.setString(3, account.getPhoneNo());
            st.setString(4, account.getUsername());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }  
    }
}
