/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller.admin;

import controller.BaseRequiredLoginController;
import dal.AccountDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Group;

/**
 *
 * @author MSI
 */
public class EditAccountController extends BaseRequiredLoginController {

    String oldUsername;
    
    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        oldUsername = username;
        Account account = new AccountDAO().getAccountInfo(username);
        request.setAttribute("account", account);
        ArrayList<Group> groups = new AccountDAO().getAllGroup();
        request.setAttribute("groups", groups);
        request.getRequestDispatcher("editAccount.jsp").forward(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = oldUsername;
        Group group = new Group();
        group.setGid(Integer.parseInt(request.getParameter("gid")));
        String name = request.getParameter("name");
        String phoneNo = request.getParameter("phoneNo");
        Account account = new Account();
        account.setUsername(username);
        account.setGroup(group);
        account.setName(name);
        account.setPhoneNo(phoneNo);
        AccountDAO db = new AccountDAO();
        db.updateAccount(account);
        response.sendRedirect("viewAccount");
    }

}
