<%@ page import="java.util.Date" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="WEB-INF/css/LoginFormCSS.css">
    <title>Login Form</title>
</head>
<body>
<section id="page content">
    <div class="content-wrap">
        <h1>Login Form</h1>
        <!--<form name="formName" action="action.html" onsubmit=validation()>-->
        <form name="formName" action="/servlet/Servlet" method="get">
            <div class="form-element">
                <label id="username">Username:</label>
                <input type="text" name="username"/>
            </div>
            <div class="form-element">
                <label id="age">Age:</label>
                <input type="text" name="age"/>
            </div>
            <div class="form-element">
                <input type="submit" value="submit"/>
            </div>
        </form>
    </div>
    <c:forEach var="username" items="${list}"><p>${username}</p></c:forEach>
</section>
</body>
</html>