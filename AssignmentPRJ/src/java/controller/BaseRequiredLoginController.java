/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author MSI
 */
@WebServlet(name = "BaseRequiredLoginController", urlPatterns = {"/BaseRequiredLoginController"})
public abstract class BaseRequiredLoginController extends HttpServlet {

    private boolean isLogin(HttpServletRequest request) {
        Account account = (Account) request.getSession().getAttribute("user");
        if (account == null) {
            Cookie[] cookies = request.getCookies();
            String username = null;
            String password = null;
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        username = cookie.getValue();
                    } else if (cookie.getName().equals("password")) {
                        password = cookie.getValue();
                    }
                    if (username != null && password != null) {
                        break;
                    }
                }
                AccountDAO db = new AccountDAO();
                account = db.getUsernameFeature(username, password);
                if (account != null) {
                    request.getSession().setAttribute("user", account);
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }

    private boolean isValid(HttpServletRequest request) {
        Account account = (Account) request.getSession().getAttribute("user");
        String pathInfo = request.getServletPath();
        return isLogin(request) && account.getFeature().contains(pathInfo.substring(1));
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isValid(request)) {
            processGet(request, response);
        } else {
            response.getWriter().println("Access denied!");
        }
    }

    protected abstract void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isValid(request)) {
            processPost(request, response);
        } else {
            response.getWriter().println("Access denied!");
        }
    }

    protected abstract void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
