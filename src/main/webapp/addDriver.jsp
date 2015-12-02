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
            <a class="navbar-brand" href="info.jsp">Logiweb</a>
        </div>
        <!-- /.navbar-header -->
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i><c:set var="username" value="${myUser.firstName}"/> ${username} <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="userProfile.jsp"><i class="fa fa-user fa-fw"></i> User Profile</a>
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

        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> Truck<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="addTruck.jsp">Add...</a>
                            </li>
                            <li>
                                <a href="editTruck.jsp">Edit...</a>
                            </li>
                            <li>
                                <a href="deleteTruck.jsp">Delete...</a>
                            </li>
                            <li>
                                <a href="/listTrucks">List...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> User/Driver<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="addDriver.jsp">Add...</a>
                            </li>
                            <li>
                                <a href="editDriver.jsp">Edit...</a>
                            </li>
                            <li>
                                <a href="deleteDriver.jsp">Delete...</a>
                            </li>
                            <li>
                                <a href="/listDrivers">List...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> Order<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/addOrder">Add...</a>
                            </li>
                            <li>
                                <a href="findOrder.jsp">Find...</a>
                            </li>
                            <li>
                                <a href="/listOrders">List...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> Cargo<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="addCargo.jsp">Add...</a>
                            </li>
                            <li>
                                <a href="findCargo.jsp">Find...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- /.navbar-static-side -->
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h3 class="page-header"> Add User/Edit User</h3>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form role="form" method="post" action="/addEditUser" onsubmit="return checkForm(this);">
                            <fieldset>
                                <c:set var="user" value="${userObject}" />
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input class="form-control" placeholder="Enter first name" name="firstName" value="${user.firstName}" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input class="form-control" placeholder="Enter last name" name="lastName" value="${user.lastName}" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Login name</label>
                                    <input class="form-control" placeholder="Enter login name" name="loginName" value="${user.login}" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>password</label>
                                    <input class="form-control" placeholder="Enter password" name="password" type="password" value="${user.password}" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Role</label>
                                    <select class="form-control" id="role" name="role">
                                        <option value="3">driver</option>
                                        <option value="2">operator</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Working hours</label>
                                    <%--<input class="form-control" placeholder="" name="hours" value="${user.hours}" autofocus>--%>
                                    <input class="form-control" placeholder="" id="hours" name="hours" value="0" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select class="form-control" id="status" name="status">
                                        <option value="1">vacant</option>
                                        <option value="2">in shift</option>
                                        <option value="3">driving</option>
                                        <option value="4">n/a</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Current city</label>
                                    <select class="form-control" id="city" name="city">
                                        <option value="1">st petersburg</option>
                                        <option value="2">moskow</option>
                                        <option value="3">kyiv</option>
                                        <option value="4">minsk</option>
                                        <option value="5">copenhagen</option>
                                        <option value="6">helsinki</option>
                                        <option value="7">prague</option>
                                        <option value="8">berlin</option>
                                        <option value="9">paris</option>
                                        <option value="10">london</option>
                                    </select>
                                </div>
                                <%--<c:set var="driverId" value="${driverId}" />--%>
                                <div class="form-group">
                                    <label>User ID</label>
                                    <input class="form-control" value="${driverId}" name="driverId" readonly="readonly">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" value="${user.password}" name="pass" type="hidden">
                                </div>
                                <c:remove var="userObject" />
                                <c:remove var="driverId" />
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
                                var re = /^[\w]{5,10}$/;

                                // validation fails if the input is blank
                                if(form.firstName.value == "" || form.firstName.value == null) {
                                    alert("Error: First Name should not be empty");
                                    form.firstName.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.firstName.value)) {
                                    alert("Error: First Name should be between 5 and 10 symbols " +
                                            "and alphanumeric");
                                    form.firstName.focus();
                                    return false;
                                }

                                // validation fails if the input is blank
                                if(form.lastName.value == "" || form.lastName.value == null) {
                                    alert("Error: Last Name should not be empty");
                                    form.lastName.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.lastName.value)) {
                                    alert("Error: Last Name should be between 5 and 10 symbols " +
                                            "and alphanumeric");
                                    form.lastName.focus();
                                    return false;
                                }

                                // regular expression to match only alphanumeric characters and spaces
                                re = /^[\w.]{5,10}$/;
                                // validation fails if the input is blank
                                if(form.loginName.value == "" || form.loginName.value == null) {
                                    alert("Error: Login Name should not be empty");
                                    form.loginName.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.loginName.value)) {
                                    alert("Error: Login Name should be between 5 and 10 symbols " +
                                            "and alphanumeric (dot is accessible)");
                                    form.loginName.focus();
                                    return false;
                                }

                                // regular expression to match only alphanumeric characters and spaces
                                re = /^.{5,256}$/;

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

                                // regular expression to match only alphanumeric characters and spaces
                                re = /^[0-9]{1,3}$/;

                                // validation fails if the input is blank
                                if(form.hours.value == "" || form.hours.value == null) {
                                    alert("Error: Hours should not be empty");
                                    form.hours.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.hours.value)) {
                                    alert("Error: Hours should be numeric and not more than 3 characters");
                                    form.hours.focus();
                                    return false;
                                }

                                // validation was successful
                                return true;
                            }

                        </script>
                        <script>

                            // set "default" values for the form
                            function setSelectedIndex(s, i)
                            {
                                s.options[i-1].selected = true;
                                return;
                            }
                            setSelectedIndex(document.getElementById("status"),${user.userStatus});
                            setSelectedIndex(document.getElementById("city"),${user.city});
                            setSelectedIndex(document.getElementById("role"),${user.role});

                        </script>
                        <script>

                            // set default value for hours
                            function setHours(s, i) {
                                if (i) {
                                    s.value = i;
                                }
                                return;
                            }

                            setHours(document.getElementById("hours"),${user.hours});

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
