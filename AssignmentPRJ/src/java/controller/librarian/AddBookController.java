/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller.librarian;

import controller.BaseRequiredLoginController;
import dal.BookDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MSI
 */
public class AddBookController extends BaseRequiredLoginController {


    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addBook.jsp").forward(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int condition = Integer.parseInt(request.getParameter("condition"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        BookDAO db = new BookDAO();
        db.addBook(author, title, condition, quantity);
        response.sendRedirect("viewTitle");
    }

}
