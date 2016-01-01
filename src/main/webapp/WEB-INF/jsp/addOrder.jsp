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
                <h4>
                    Creating Order. Step 1 out of 3:
                </h4>
                <h3 class="page-header">
                    Add Cargos to Order
                </h3>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form role="form" method="post" action="/addOrder" onsubmit="return checkForm(this);">
                        <%--<form role="form" method="post" action="addOrderTruck.jsp" >--%>
                            <fieldset>
                                <div class="form-group">
                                    <label>Select Cargos</label>
                                    <select name="cargos" multiple class="form-control">
                                        <!-- get the list of cargos -->
                                        <c:forEach var="cargo" items="${cargoList}">
                                            <option value="${cargo.id}">
                                                ${cargo.id}&nbsp;&nbsp;&nbsp;${cargo.cargoName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="step" value="1" type="hidden">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <!-- a href="<c:url value="/info" />" class="btn btn-md btn-success btn-block">Login</a-->
                                <button type="submit" class="btn btn-default">Submit</button>
                                <button type="reset" class="btn btn-default">Reset</button>
                            </fieldset>
                        </form>
                        <script>
                            // check the form input
                            function checkForm(form) {
                                if (form.cargos.value == null || form.cargos.value == "") {
                                    alert("Please select cargos for the order");
                                    form.cargos.focus();
                                    return false;
                                }

                                // check passed
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
<script src="<c:url value="/resources/bower_components/jquery/dist/jquery.min.js" />"></script>

<!-- Bootstrap Core JavaScript -->
<script src="<c:url value="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js" />"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="<c:url value="/resources/bower_components/metisMenu/dist/metisMenu.min.js" />"></script>

<!-- Custom Theme JavaScript -->
<script src="<c:url value="/resources/dist/js/sb-admin-2.js" />"></script>

</body>

</html>
