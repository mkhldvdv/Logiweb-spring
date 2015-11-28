<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/LoginFormCSS.css">
    <title>Login Form</title>
</head>
<body>
<section id="page content">
    <div class="content-wrap">
        <h1>Login Form</h1>
        <!--<form name="formName" action="action.html" onsubmit=validation()>-->
        <form name="formName" action="/servlet/LoginServlet" method="post" onsubmit="validation();">
            <div class="form-element">
                <label id="username">Username:</label>
                <input type="text" name="username"/>
            </div>
            <div class="form-element">
                <label id="password">Password:</label>
                <input type="password" name="password"/>
            </div>
            <div class="form-element">
                <input type="submit" value="Log in"/>
            </div>
        </form>
        <script>
            function validation(){
                var inputLogin = document.getElementsByName("username");
                var passInput = document.getElementsByName("password");

                var loginMatch = /^[A-Za-z0-9]{5,10}$/;
                if (!inputLogin[0].value.match(loginMatch)) {
                    alert("Login name is incorrect");
                    return false;
                }

                var passMatch = /^[A-Za-z0-9]{5,10}$/;
                if (!passInput[0].value.match(passMatch)) {
                    alert("Password is incorrect");
                    return false;
                }

                return true;
            }
        </script>
    </div>
    <c:forEach var="username" items="${list}"><p>${username}</p></c:forEach>
</section>
</body>
</html>