<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Logiweb</title>

    <!-- Bootstrap Core CSS -->
    <link href="<c:url value="/resources/bower_components/bootstrap/dist/css/bootstrap.min.css" />" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="<c:url value="/resources/bower_components/metisMenu/dist/metisMenu.min.css" />" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<c:url value="/resources/dist/css/sb-admin-2.css" />" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<c:url value="/resources/bower_components/font-awesome/css/font-awesome.min.css" />" rel="stylesheet" type="text/css">

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
            <a class="navbar-brand" href="<c:url value="/info" />">Logiweb</a>
        </div>
        <!-- /.navbar-header -->
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i> ${pageContext.request.userPrincipal.name} <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="<c:url value="/userProfile" />"><i class="fa fa-user fa-fw"></i> User Profile</a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="<c:url value="/logout" />"><i class="fa fa-sign-out fa-fw"></i> Sign out</a>
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
                                <a href="<c:url value="/addTruck" />">Add...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/editTruck" />">Edit...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/deleteTruck" />">Delete...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/listTrucks" />">List...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> User/Driver<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="<c:url value="/addDriver" />">Add...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/editDriver" />">Edit...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/deleteDriver" />">Delete...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/listDrivers" />">List...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> Order<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="<c:url value="/addOrder" />">Add...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/findOrder" />">Find...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/listOrders" />">List...</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw"></i> Cargo<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="<c:url value="/addCargo" />">Add...</a>
                            </li>
                            <li>
                                <a href="<c:url value="/findCargo" />">Find...</a>
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
                        <form:form role="form" method="post" action="addEditUser" commandName="user" onsubmit="return checkForm(this);">
                            <fieldset>
                                <c:if test="${user.id > 0}">
                                    <div class="form-group">
                                        <label>User ID:</label>
                                        ${user.id}
                                        <form:input path="id" class="form-control" value="${user.id}" name="userId" type="hidden" />
                                    </div>
                                </c:if>
                                <%--<div class="form-group">--%>
                                    <%--<input class="form-control" value="${user.password}" name="pass" type="hidden">--%>
                                <%--</div>--%>
                                <div class="form-group">
                                    <label>First Name</label>
                                    <form:input path="firstName" class="form-control" placeholder="Enter first name" name="firstName" value="${user.firstName}" autofocus="true" />
                                    <form:errors path="firstName" cssClass="error"/>
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <form:input path="lastName" class="form-control" placeholder="Enter last name" name="lastName" value="${user.lastName}" autofocus="true" />
                                    <form:errors path="lastName" cssClass="error"/>
                                </div>
                                <div class="form-group">
                                    <label>Login name</label>
                                    <form:input path="login" class="form-control" placeholder="Enter login name" name="login" value="${user.login}" autofocus="true" />
                                    <form:errors path="login" cssClass="error"/>
                                </div>
                                <div class="form-group">
                                    <label>password</label>
                                    <form:input path="password" class="form-control" placeholder="Enter password" name="password" type="password" value="${user.password}" autofocus="true" />
                                    <form:errors path="password" cssClass="error"/>
                                </div>
                                <div class="form-group">
                                    <label>Role</label>
                                    <form:select path="roleId" class="form-control" id="role" name="role">
                                        <form:option value="3">driver</form:option>
                                        <form:option value="2">operator</form:option>
                                        <%--<form:options items="${roles}" />--%>
                                    </form:select>
                                </div>
                                <div class="form-group">
                                    <label>Working hours</label>
                                    <%--<input class="form-control" placeholder="" name="hours" value="${user.hours}" autofocus>--%>
                                    <%--<form:input path="hours" class="form-control" placeholder="" id="hours" name="hours" value="0" autofocus="true" />--%>
                                    <form:input path="hours" class="form-control" placeholder="0" id="hours" name="hours" value="${user.hours}" autofocus="true" />
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <form:select path="userStatusId" class="form-control" id="status" name="status">
                                        <form:option value="1">vacant</form:option>
                                        <form:option value="2">in shift</form:option>
                                        <form:option value="3">driving</form:option>
                                        <form:option value="4">n/a</form:option>
                                    </form:select>
                                </div>
                                <div class="form-group">
                                    <label>Current city</label>
                                    <form:select path="cityId" class="form-control" id="city" name="city">
                                        <form:option value="1">st petersburg</form:option>
                                        <form:option value="2">moskow</form:option>
                                        <form:option value="3">kyiv</form:option>
                                        <form:option value="4">minsk</form:option>
                                        <form:option value="5">copenhagen</form:option>
                                        <form:option value="6">helsinki</form:option>
                                        <form:option value="7">prague</form:option>
                                        <form:option value="8">berlin</form:option>
                                        <form:option value="9">paris</form:option>
                                        <form:option value="10">london</form:option>
                                        <%--<form:option value="0">n/a</form:option>--%>
                                    </form:select>
                                </div>
                                <button type="submit" class="btn btn-default">Submit</button>
                                <button type="reset" class="btn btn-default">Reset</button>
                            </fieldset>
                        </form:form>
                        <script>

                            function checkForm(form)
                            {
                                // regular expression to match only alphanumeric characters and spaces
                                var re = /^[\w -]{5,30}$/;

                                // validation fails if the input is blank
                                if(form.firstName.value == "" || form.firstName.value == null) {
                                    alert("Error: First Name should not be empty");
                                    form.firstName.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.firstName.value)) {
                                    alert("Error: First Name should be between 5 and 30 symbols " +
                                            "and alphanumeric (space and minus acceptable)");
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
                                    alert("Error: Last Name should be between 5 and 30 symbols " +
                                            "and alphanumeric (space and minus acceptable)");
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
                                re = /^.{5,60}$/;

                                // validation fails if the input is blank
                                if(form.password.value == "" || form.password.value == null) {
                                    alert("Error: Password should not be empty");
                                    form.password.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.password.value)) {
                                    alert("Error: Password should be between 5 and 60 symbols");
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
<script src="<c:url value="/resources/bower_components/jquery/dist/jquery.min.js" />"></script>

<!-- Bootstrap Core JavaScript -->
<script src="<c:url value="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js" />"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="<c:url value="/resources/bower_components/metisMenu/dist/metisMenu.min.js" />"></script>

<!-- Custom Theme JavaScript -->
<script src="<c:url value="/resources/dist/js/sb-admin-2.js" />"></script>

</body>

</html>
