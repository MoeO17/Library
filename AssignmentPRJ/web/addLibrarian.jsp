<%-- 
    Document   : addAccount
    Created on : Mar 28, 2020, 9:23:23 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Librarian</title>
        <!--Made with love by Mutiullah Samim -->

        <!--Bootsrap 4 CDN-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <!--Fontawesome CDN-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

        <!--Custom styles-->
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script>
            function checkNumber() {
                var x;

                x = document.getElementById("phoneNo").value;

                if (isNaN(x) || x < 100000000 || x > 9999999999) {
                    alert("Invalid phone number");
                    return false;
                }
            }
        </script>
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
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <h3>Add Librarian</h3>
                    </div>
                    <div class="card-body">
                        <form action="addLibrarian" method="post" onsubmit="return checkNumber()">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" name="username" class="form-control" placeholder="username" required>

                            </div>
                            <c:if test="${requestScope.error != null}">
                                <i style="color: red">Username already taken, please choose another!</i>
                            </c:if>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" name="password" class="form-control" placeholder="password" required>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" name="name" class="form-control" placeholder="name" required>
                            </div>

                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" name="phoneNo" class="form-control" placeholder="phoneNo" required>
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Save" class="btn float-right login_btn">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
