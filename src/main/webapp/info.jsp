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
                        <i class="fa fa-user fa-fw"></i>
                            <c:set var="username" value="${myUser.firstName}"/> ${username}
                        <i class="fa fa-caret-down"></i>
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
                    <h3 class="page-header"> Usage</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <div class="col-lg-8">                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-fw"></i> Buttons to the left HowTo...
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <p>Here you can find the short description of what could be done on the site.<br>
                            On the left panel you can see "directories" with main objects.<br>
                            Click on any of them and you will see the available actions which could be performed against objects and database.<br><br>

                            0. The first button is in the top left corner called "Logiweb". That is a link to the current page with description. That button presents on every page of the site.<br>
                            Below are the links with objects and actions.<br><br>
                            1. "Truck" menu:<br>
                            here you can "Add", "Edit", "Delete" trucks and call the "List" of all available trucks.<br>
                            2. "User/Driver" menu:<br>
                            here you can "Add", "Edit", "Delete" operators and drivers (both are users) into the system and call the "List" of all available drivers (not operators).<br>
                            3. "Order" menu:<br>
                            here you can "Add" order, "Find" specified order (to get the full info about it) and call the "List" of all orders.<br>
                            4. "Cargo" menu:<br>
                            here you can "Add" new cargo and "Find" sepcified cargo (to get the full info about it).</p>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-8 -->
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-fw"></i> Button at the top Howto...
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            Button at the top right corner can be used to see "User Profile" details.<br>
                            "Sign out" button is also there if you will decide to leave the site.<br>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->                    
                </div>
                <!-- /.col-lg-4 -->
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
