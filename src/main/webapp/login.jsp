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
                        <h3 class="panel-title">Logiweb: Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" action="info.jsp" onsubmit="validation()">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Enter login..." name="login" type="login" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Enter password" name="password" type="password" value="">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <!-- a href="info.jsp" class="btn btn-md btn-success btn-block">Login</a-->
								<input type="submit" class="btn btn-md btn-success btn-block" value="Login">
                            </fieldset>
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

</body>

</html>
