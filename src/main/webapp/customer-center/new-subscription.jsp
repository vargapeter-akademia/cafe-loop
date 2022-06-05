<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/main.css">

    <title>Új előfizetés</title>
</head>
<body>

<%@include file="../fragments/navbar.jsp" %>

<div class="container-fluid bg-1 text-center">
    <img src="${pageContext.request.contextPath}/images/logo-big.png" class="img-responsive img-circle"
         style="display:inline;" width="150" height="150">
    <h2>Új előfizetés</h2>
</div>

<script>

    function chooseProduct(id, quantity) {
        $.post(
            '${pageContext.request.contextPath}/customer-center/select-product',
            {id: id, quantity: quantity},
            (data, status) => {

            }
        )
    }
</script>

<sql:query var="products" dataSource="jdbc/mysql">
    select id, name, price, description, image_path
    from product;
</sql:query>

<sql:query var="products" dataSource="jdbc/mysql">
    select id, name, price, description, image_path
    from product;
</sql:query>

<sql:query var="products" dataSource="jdbc/mysql">
    select id, name, price, description, image_path
    from product;
</sql:query>

<div class="container container-fluid">


    <div class="row">

        <div class="col-md-8">
            <h2 class="text-muted">Előfizetés adatai</h2>

            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#subscription">Szállítás</a></li>
                <li><a data-toggle="tab" href="#catalog">Termék katalógus</a></li>
            </ul>

            <div class="tab-content">
                <div id="subscription" class="tab-pane fade in active">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form action="/customer-center/new-subscription" method="post">
                                <div class="input-group">
                                    <span class="input-group-addon">Cím</span>
                                    <input class="form-control" name="address" required
                                           placeholder="1027. Budapest Gipsz Jakab utca 4.">
                                </div>
                                <br>

                                <div class="input-group">
                                    <span class="input-group-addon">Szállítás gyakorisága</span>
                                    <select class="form-control" name="frequencyId">
                                        <c:forEach items="${frequencies.rows}" var="freq">
                                            <option value="${freq.id}">${freq.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <br>

                                <button type="submit" class="btn btn-lg btn-block bg-1" title="">Új előfizetés elküldése
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="catalog" class="tab-pane fade">

                    <ul class="list-group">
                        <c:forEach items="${products.rows}" var="product">

                            <li class="list-group-item">

                                <div class="row">

                                    <div class="col-md-4">
                                        <img class="img-thumbnail"
                                             src="${pageContext.request.contextPath}/images/${product.image_path}">
                                    </div>

                                    <div class="col-md-8">
                                        <form action="${pageContext.request.contextPath}/customer-center/select-product"
                                              method="get">

                                            <h3>${product.name} (${product.price} Ft / csomag)</h3>
                                            <p>${product.description}</p>
                                            <div class="input-group">
                                                <span class="input-group-addon">Mennyiség</span>
                                                <input class="form-control" type="number" name="quantity"
                                                       value="${sessionScope.selectedProducts.get(product.id)}">
                                                <div class="input-group-btn">
                                                    <button class="btn btn-link" type="submit">
                                                        <i class="glyphicon glyphicon-plus"></i>
                                                    </button>
                                                </div>
                                                <input name="productId" value="${product.id}" hidden>
                                            </div>
                                            <br>
                                        </form>
                                    </div>

                                </div>
                            </li>

                        </c:forEach>
                    </ul>


                </div>
            </div>

        </div>

        <div class="col-md-4">
            <h2 class="text-muted">Megrendelendő termékek</h2>
            <ul class="list-group mb-3">
                <c:forEach items="${sessionScope.selectedProducts}" var="selectedProduct">
                    <li class="list-group-item">
                        <b>${selectedProduct.key}</b>
                        <small class="text-muted">3500 Forint</small>
                        <span class="badge">${selectedProduct.value} csomag</span>
                    </li>
                </c:forEach>
                <li class="list-group-item">Összesen: <b>19600 Forint</b></li>
            </ul>
        </div>

    </div>

</div>

</body>
</html>