/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.librarian;

import controller.BaseRequiredLoginController;
import dal.BookDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MSI
 */
public class ReturnBookController extends BaseRequiredLoginController {

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("returnBook.jsp").forward(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String[] bids = request.getParameterValues("bids");
        String[] conditions = request.getParameterValues("conditions");
        BookDAO db = new BookDAO();
        for (int i = 0; i < bids.length; i++) {
            db.returnBook(username, bids[i], conditions[i]);
        }
        response.sendRedirect("viewTitle");
    }

}
