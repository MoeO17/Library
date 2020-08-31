<%-- 
    Document   : makeTransaction
    Created on : Mar 29, 2020, 11:27:49 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Return Book</title>
        <!--Made with love by Mutiullah Samim -->

        <!--Bootsrap 4 CDN-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <!--Fontawesome CDN-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

        <!--Custom styles-->
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script>
            var count = 0;
            function appendBid() {
                count++;
                var div = document.createElement("div");
                div.id = "bid" + count;
                var div1 = document.createElement("div");
                div1.class = "input-group form-group select-group";
                var div2 = document.createElement("div");
                div2.class = "input-group-prepend";
                var span = document.createElement("span");
                span.class = "input-group-text";
                var i = document.createElement("i");
                i.class = "fas fa-book";
                span.appendChild(i);
                div2.appendChild(span);
                div1.appendChild(div2);
                div.appendChild(div1);
                var inputBid = document.createElement("input");
                inputBid.type = "number";
                inputBid.name = "bids";
                inputBid.id = "bid" + count;
                inputBid.class = "form-control";
                inputBid.placeholder = "bid";
                inputBid.required= "true";
                div.appendChild(inputBid);
                var selectCond = document.createElement("SELECT");
                selectCond.class = "form-control";
                selectCond.name = "conditions";
                var option = document.createElement("option");
                option.value = "4";
                option.text = "Very Good";
                selectCond.add(option);
                option = document.createElement("option");
                option.value = "3";
                option.text = "Good";
                selectCond.add(option);
                option = document.createElement("option");
                option.value = "2";
                option.text = "Fair";
                selectCond.add(option);
                option = document.createElement("option");
                option.value = "1";
                option.text = "Poor";
                selectCond.add(option);
                div.appendChild(selectCond);
                div.innerHTML += "<input type='button' value='Remove' onclick='removeBid(" + count + ")'/>";
                div.appendChild(document.createElement("br"));
                document.getElementById("container").appendChild(div);
            }

            function removeBid(index) {
                var container = document.getElementById("container");
                var bid = document.getElementById("bid" + index);
                container.removeChild(bid);
                document.getElementById("count").value = count;
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
                        <h3>Return Book</h3>
                    </div>
                    <div class="card-body">
                        <form action="returnBook" method="post">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" name="username" class="form-control" placeholder="username" required>
                            </div>

                            <div class="input-group select-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="number" name="bids" class="form-control" placeholder="bid" required>
                                <select name="conditions" class="form-control">
                                    <option value="4">Very Good</option>
                                    <option value="3">Good</option>
                                    <option value="2">Fair</option>
                                    <option value="1">Poor</option>
                                </select>
                            </div>


                            <div id="container">                                
                            </div>

                            <div class="form-group">
                                <input type="button" value="More Book" class="btn float-book" onclick="appendBid();">
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
