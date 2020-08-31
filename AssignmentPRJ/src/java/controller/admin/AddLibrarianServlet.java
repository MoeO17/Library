/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import controller.BaseRequiredLoginController;
import dal.AccountDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MSI
 */
public class AddLibrarianServlet extends BaseRequiredLoginController {

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addLibrarian.jsp").forward(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phoneNo = request.getParameter("phoneNo");
        AccountDAO db = new AccountDAO();
        boolean success = db.addAccount(username, password, 2, name, phoneNo);
        if (success) {
            response.sendRedirect("viewTitle");
        } else {
            request.setAttribute("error", true);
            request.getRequestDispatcher("addLibrarian.jsp").forward(request, response);
        }
    }

}
