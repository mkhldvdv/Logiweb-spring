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
                    <i class="fa fa-user fa-fw"></i>
                         ${pageContext.request.userPrincipal.name}
                    <i class="fa fa-caret-down"></i>
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
                <h3 class="page-header"> Add Truck/Edit Truck</h3>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form role="form" method="post" action="/addEditTruck" onsubmit="return checkForm(this);">
                            <fieldset>
                                <c:set var="user" value="${userObject}" />
                                <div class="form-group">
                                    <label>Regional Number</label>
                                    <input class="form-control" placeholder="Enter regional number" name="regNum" value="${user.regNum}" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Shift count</label>
                                    <select class="form-control" id="shift" name="shift">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                    </select>
                                    <script>
                                        function setSelectedIndex(s, i)
                                        {
                                            s.options[i-1].selected = true;
                                            return;
                                        }
                                        setSelectedIndex(document.getElementById("shift"),${user.driverCount});
                                        setSelectedIndex(document.getElementById("status"),${user.truckStatus});
                                        setSelectedIndex(document.getElementById("city"),${user.city});
                                    </script>
                                </div>
                                <div class="form-group">
                                    <label>Capacity</label>
                                    <input class="form-control" placeholder="Enter capacity" name="capacity" value="${user.capacity}" autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select class="form-control" id="status" name="status">
                                        <option value="1">valid</option>
                                        <option value="2">not valid</option>
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
                                <%--<c:set var="truckId" value="${truckId}" />--%>
                                <div class="form-group">
                                    <label>Truck ID</label>
                                    <input class="form-control" value="${truckId}" name="truckId" readonly="readonly">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" value="add" name="action" type="hidden">
                                </div>
                                <c:remove var="userObject" />
                                <c:remove var="truckId" />
                                <!-- Change this to a button or input when using this as a form -->
                                <!-- a href="<c:url value="/info" />" class="btn btn-md btn-success btn-block">Login</a-->
                                <button type="submit" class="btn btn-default">Submit</button>
                                <button type="reset" class="btn btn-default">Reset</button>
                            </fieldset>
                        </form>
                        <script>

                            function checkForm(form)
                            {
                                // regular expression to match only alphanumeric characters and spaces
                                var re = /^[a-zA-Z]{2}[0-9]{5}$/;

                                // validation fails if the input is blank
                                if(form.regNum.value == "" || form.regNum.value == null) {
                                    alert("Error: regNum should not be empty");
                                    form.regNum.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.regNum.value)) {
                                    alert("Error: regNum should be exaclty 7 characters: 2 letters followed by 5 digits");
                                    form.regNum.focus();
                                    return false;
                                }

                                // regular expression to match only alphanumeric characters and spaces
                                re = /^[0-9]{1,2}$/;

                                // validation fails if the input is blank
                                if(form.capacity.value == "" || form.capacity.value == null) {
                                    alert("Error: capacity should not be empty");
                                    form.capacity.focus();
                                    return false;
                                }

                                // validation fails if the input doesn't match our regular expression
                                if(!re.test(form.capacity.value)) {
                                    alert("Error: capacity should be numeric and not more than 2 characters");
                                    form.capacity.focus();
                                    return false;
                                }

                                // validation was successful
                                return true;
                            }

                        </script>
                        <script>

                            // set "default" values for the form from updated truck
                            function setSelectedIndex(s, i)
                            {
                                s.options[i-1].selected = true;
                                return;
                            }
                            setSelectedIndex(document.getElementById("shift"),${user.driverCount});
                            setSelectedIndex(document.getElementById("status"),${user.truckStatus});
                            setSelectedIndex(document.getElementById("city"),${user.city});

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
