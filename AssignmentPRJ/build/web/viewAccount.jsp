<%-- 
    Document   : viewAccount
    Created on : Mar 28, 2020, 10:19:20 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Account</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="viewTitle">Library Management</a>
            <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
                <c:if test="${sessionScope.user eq null}">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="login">Log In</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register">Sign Up</a>
                        </li>
                    </ul>
                </c:if>
                <c:if test="${sessionScope.user != null}">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Welcome ${sessionScope.user.name}</a>
                        </li>
                        <c:if test="${sessionScope.user.group.gid == 3}">
                            <li class="nav-item">
                                <a class="nav-link" href="viewRentedBook">Rented Book</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.group.gid == 1}">
                            <li class="nav-item">
                                <a class="nav-link" href="viewAccount">View Account</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="addLibrarian">Add Librarian</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.group.gid == 2}">
                            <li class="nav-item">
                                <a class="nav-link" href="addBook">Add Book</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="rentBook">Rent Book</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="returnBook">Return Book</a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="logout">Log Out</a>
                        </li>
                    </ul>
                </c:if>
            </div>
        </nav>
        <table border="1" class="table table-striped">
            <tr style="font-weight: bold; text-align: center">
                <td>Username</td>
                <td>Group</td>
                <td>Name</td>
                <td>Phone Number</td>
                <td></td>
            </tr>
            <c:forEach items="${requestScope.accounts}" var="a">
                <tr>
                    <td>${a.username}</td>
                    <td>${a.group.gname}</td>
                    <td>${a.name}</td>
                    <td>${a.phoneNo}</td>
                    <td><a href="editAccount?username=${a.username}">Edit</a></td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
