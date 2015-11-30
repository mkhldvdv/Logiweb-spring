<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Logiweb</title>

    <!-- Bootstrap Core CSS -->
    <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Logiweb: Welcome</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" action="/login" onsubmit="return checkForm(this);">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Enter login..." name="login" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Enter password" name="password" type="password" value="">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <!-- a href="info.jsp" class="btn btn-md btn-success btn-block">Login</a-->
                                <input type="submit" class="btn btn-md btn-success btn-block" value="Sign in">
                            </fieldset>
                        </form>
                        <script>

                            function checkForm(form)
                            {
                                // regular expression to match only alphanumeric characters and spaces
                                var re = /^[\w.]{5,10}$/;

                                // validation fails if the input is blank
                                if(form.login.value == "" || form.login.value == null) {
                                    alert("Error: Login should not be empty");
                                    form.login.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.login.value)) {
                                    alert("Error: Login should be between 5 and 10 symbols " +
                                            "and alphanumeric (dot is also acceptible)");
                                    form.login.focus();
                                    return false;
                                }

                                // regular expression to match only alphanumeric characters and spaces
                                re = /^.{5,10}$/;

                                // validation fails if the input is blank
                                if(form.password.value == "" || form.password.value == null) {
                                    alert("Error: Password should not be empty");
                                    form.password.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.password.value)) {
                                    alert("Error: Password should be between 5 and 10 symbols");
                                    form.password.focus();
                                    return false;
                                }

                                // validation was successful
                                return true;
                            }

                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="dist/js/sb-admin-2.js"></script>

    <c:set var="noUser" value="${noUser}"/>
    <c:if test="${noUser}"><script>alert("Error: Invalid User/Password. Please try again");</script></c:if>
    <c:remove var="noUser"/>

</body>

</html>