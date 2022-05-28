<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/main.css">
    <title>Új előfizetés</title>
</head>
<body>
<%@include file="../fragments/navbar.jsp" %>

<div class="container-fluid bg-1 text-center">
    <img src="${pageContext.request.contextPath}/images/logo-big.png" class="img-responsive img-circle" style="display:inline;" width="150" height="150">
    <h2>Új előfizetés hozzáadása</h2>
</div>

<sql:query var="products" dataSource="jdbc/mysql">
    select *
    from product;
</sql:query>

<sql:query var="frequencies" dataSource="jdbc/mysql">
    select *
    from frequency;
</sql:query>

<form action="/customer-center/new-subscription" method="post">
    <div class="container">

        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12">
                <h3>Bootstrap 3 Example Form:-</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Input Sizing</h3>
                    </div>

                    <div class="panel-body">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">@</span>
                            <input type="text" class="form-control input-lg" placeholder="Username">
                        </div>
                        <br>
                        <div class="input-group">
                            <span class="input-group-addon">$</span>
                            <input type="text" class="form-control" placeholder="Currency">
                        </div>
                        <br>
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon">{}</span>
                            <input type="text" class="form-control" placeholder="Code">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Height Sizing</h3>
                    </div>

                    <div class="panel-body">
                        <select class="form-control input-lg">
                            <option value="">.input-lg</option>
                        </select>
                        <br>
                        <select class="form-control">
                            <option value="">Default select</option>
                        </select>
                        <br>
                        <select class="form-control input-sm">
                            <option value="">.input-sm</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>


        <!-- Row start -->
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Input Groups</h3>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-4 col-sm-4">
                                <div class="input-group">
                                    <span class="input-group-addon">@</span>
                                    <input type="text" class="form-control" placeholder="Username">
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control">
                                    <span class="input-group-addon">.00</span>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-4">
                                <div class="input-group">
                                    <span class="input-group-addon">$</span>
                                    <input type="text" class="form-control">
                                    <span class="input-group-addon">.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row end -->

        <!-- Row start -->
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Button Addons</h3>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-6 col-sm-6 col-sx-6">
                                <div class="input-group">
                <span class="input-group-btn">
                  <button class="btn btn-default" type="button" title="">Go!</button>
                </span>
                                    <input type="text" class="form-control">
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6 col-sx-6">
                                <div class="input-group">
                                    <input type="text" class="form-control">
                                    <span class="input-group-btn">
                  <button class="btn btn-default" type="button" data-original-title="" title="">Submit!</button>
                </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row end -->


        <!-- Row start -->
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Check Boxes &amp; Radio Addons</h3>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-3 col-sm-3">
                                <div class="input-group">
                <span class="input-group-addon">
                  <input type="checkbox">
                </span>
                                    <input type="text" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-3">
                                <div class="input-group">
                <span class="input-group-addon">
                  <input type="checkbox" checked="">
                </span>
                                    <input type="text" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-3">
                                <div class="input-group">
                <span class="input-group-addon">
                  <input type="radio" name="optionsRadio" id="optionsRadiosX" value="optionx">
                </span>
                                    <input type="text" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-3">
                                <div class="input-group">
                <span class="input-group-addon">
                  <input type="radio" name="optionsRadio" id="optionsRadiosY" value="optiony" checked="">
                </span>
                                    <input type="text" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row end -->

        <!-- Row start -->
        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Check boxes</h3>
                    </div>

                    <div class="panel-body">
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox1" value="option1" checked=""> 1
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox2" value="option2"> 2
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox3" value="option3" disabled=""> 3
                        </label>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Radio buttons</h3>
                    </div>

                    <div class="panel-body">
                        <label class="radio-inline">
                            <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked=""> 1
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">2
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="optionsRadios" id="optionsRadios3" value="option2" disabled="">3
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row end -->

        <!-- Row start -->
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Inline Form</h3>
                    </div>

                    <div class="panel-body">
                        <form class="form-inline" role="form">
                            <div class="form-group">
                                <label class="sr-only" for="exampleInputEmail2">Email address</label>
                                <input type="email" class="form-control" id="exampleInputEmail2"
                                       placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="exampleInputPassword2">Password</label>
                                <input type="password" class="form-control" id="exampleInputPassword2"
                                       placeholder="Password">
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                            <button type="submit" class="btn btn-info" title="">Sign in</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row end -->

        <!-- Row start -->
        <div class="row">
            <div class="col-md-12 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <i class="icon-calendar"></i>
                        <h3 class="panel-title">Inputs</h3>
                    </div>

                    <div class="panel-body">
                        <form class="form-horizontal row-border" action="#">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Default input field</label>
                                <div class="col-md-10">
                                    <input type="text" name="regular" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Password</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="password" name="pass">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">With placeholder</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="placeholder"
                                           placeholder="placeholder">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Disabled field</label>
                                <div class="col-md-10">
                                    <input type="text" name="disabled" disabled="disabled" value="disabled"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Read only field</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="readonly" readonly=""
                                           value="read only">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Help text</label>
                                <div class="col-md-10">
                                    <input type="text" name="regular" class="form-control">
                                    <span class="help-block">A block of help text that breaks onto a new line and may extend beyond one line.</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Predefined value</label>
                                <div class="col-md-10">
                                    <input type="text" name="regular" value="http://" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">With icon</label>
                                <div class="col-md-10">
                                    <input type="text" name="regular" class="form-control">
                                    <i class="icon-pencil input-icon"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="labelfor" class="col-md-2 control-label">Clickable label</label>
                                <div class="col-md-10">
                                    <input type="text" name="labelfor" id="labelfor" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Column sizing</label>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <input type="text" class="form-control" placeholder=".col-xs-3">
                                        </div>
                                        <div class="col-xs-5">
                                            <input type="text" class="form-control" placeholder=".col-xs-5">
                                        </div>
                                        <div class="col-xs-4">
                                            <input type="text" class="form-control" placeholder=".col-xs-4">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group has-success">
                                <label class="col-md-2 control-label">Input success</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" id="inputSuccess"
                                           placeholder="Input Success">
                                    <i class="icon-pencil input-icon success"></i>
                                </div>
                            </div>
                            <div class="form-group has-warning">
                                <label class="col-md-2 control-label">Input warning</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" id="inputWarning"
                                           placeholder="Input Warning">
                                    <i class="icon-pencil input-icon warning"></i>
                                </div>
                            </div>
                            <div class="form-group has-error">
                                <label class="col-md-2 control-label">Input error</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" id="inputError" placeholder="Input Error">
                                    <i class="icon-pencil input-icon error"></i>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row end -->

    </div>
</form>


<%--    <div class="container bg-3">--%>
<%--        <h3 class="text-center">Termék kiválasztása</h3>--%>

<%--        <c:forEach items="${products.rows}" var="product">--%>

<%--            <div class="row">--%>
<%--                <div class="col-sm-3">--%>
<%--                    <img src="${pageContext.request.contextPath}/images/products/${product.image_path}"--%>
<%--                         class="img-thumbnail">--%>
<%--                </div>--%>
<%--                <div class="col-sm-9">--%>
<%--                    <h3>${product.name}</h3>--%>
<%--                    <p>${product.description}</p>--%>
<%--                    <label for="">Mennyiség: </label>--%>
<%--                    <input type="radio" name="product" value="${product.id}">--%>
<%--                    <p><input type="radio" name="product" value="${product.id}"> Ezt választom! </p>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--        </c:forEach>--%>

<%--    </div>--%>

<%--    <div class="container bg-3">--%>
<%--        <h3 class="text-center">Szállítás adatai</h3>--%>

<%--        <div class="form-group">--%>
<%--            <label for="sel1">Gyakoriság:</label>--%>
<%--            <select class="form-control" id="sel1">--%>
<%--                <c:forEach items="${frequencies.rows}" var="frequency">--%>
<%--                    <option value="${frequency.id}">${frequency.name}</option>--%>
<%--                </c:forEach>--%>
<%--            </select>--%>

<%--        </div>--%>

<%--    </div>--%>

<%--    <div class="container bg-3 text-center">--%>
<%--        <button type="submit" class="btn">Előfizetés elküldése</button>--%>
<%--    </div>--%>
</form>


</body>
</html>
