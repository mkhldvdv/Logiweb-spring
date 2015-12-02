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

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="infoDriver.jsp">Logiweb</a>
            </div>
            <!-- /.navbar-header -->
            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>
                            <c:set var="username" value="${myUser.firstName}"/> ${username}
                        <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="driverProfile.jsp"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="/logout"><i class="fa fa-sign-out fa-fw"></i> Sign out</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->
        </nav>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header"> Get Info</h3>
                    <p>Here you can find the short description of what could be done on the site.<br><br>
                    The first button is in the top left corner called "Logiweb". That is a link to the current page with description. That button presents on every page of the site.</p>

                    <p>You can find all of your assignments by submiting the form fulfilled with your User ID.<br>
                    You can easily find your User ID in "User Profile" page in the top right corner by clicking the button with your name and then choosing "User Profile" link in dropdown menu.<br>
                    "Sign out" button is also there if you will decide to leave the site.</p>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form role="form" method="post" action="/infoForDriver" onsubmit="return checkForm(this)">
                                <fieldset>
                                    <div class="form-group">
                                        <div class="form-group">
                                            <label>Driver ID</label>
                                            <input class="form-control" placeholder="Enter driver ID" name="driverId" autofocus>
                                        </div>
                                    </div>
                                    <!-- Change this to a button or input when using this as a form -->
                                    <!-- a href="info.jsp" class="btn btn-md btn-success btn-block">Login</a-->
                                    <button type="submit" class="btn btn-default">Submit</button>
                                    <button type="reset" class="btn btn-default">Reset</button>
                                </fieldset>
                            </form>
                            <script>

                                function checkForm(form)
                                {
                                    // regular expression to match only alphanumeric characters and spaces
                                    var re = /^[0-9]+$/;

                                    // validation fails if the input is blank
                                    if(form.driverId.value == "" || form.driverId.value == null) {
                                        alert("Error: driver ID should not be empty");
                                        form.driverId.focus();
                                        return false;
                                    }

                                    // validation fails if the input doesn't match our regular expression
                                    if(!re.test(form.driverId.value)) {
                                        alert("Error: driver ID should be numeric and at least 1 character");
                                        form.driverId.focus();
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
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->

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
