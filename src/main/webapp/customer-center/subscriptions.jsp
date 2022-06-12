<%@ page import="hu.ak.generics.cafeloop.util.DeliveryUtils" %>
<%@ page import="hu.ak.generics.cafeloop.util.DateUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
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

    <title>Előfizetések</title>
</head>
<body>

<%@include file="../fragments/navbar.jsp" %>

<div class="container-fluid bg-1 text-center">
    <img src="${pageContext.request.contextPath}/images/logo-big.png" class="img-responsive img-circle"
         style="display:inline;" width="150" height="150">
    <h2>Előfizetések</h2>
</div>

<sql:query var="subscriptions" dataSource="jdbc/mysql">
    select subscription.id as id, subscription_date, address, code
    from subscription
    join frequency on subscription.frequency_id = frequency.id
    where customer_id = ?;
    <sql:param value="${sessionScope.loggedInCustomer.id}"/>
</sql:query>

<div class="container container-fluid">
    <c:forEach var="subscription" items="${subscriptions.rows}">

        <sql:query var="products" dataSource="jdbc/mysql">
            select product.name, subscription_item.quantity, subscription_item.quantity * product.price "price_per_product"
            from subscription_item
            join product on product.id = subscription_item.product_id
            where subscription_id = ?;
            <sql:param value="${subscription.id}"/>
        </sql:query>

        <sql:query var="totalPrice" dataSource="jdbc/mysql">
            select sum(price * quantity) as total_price
            from subscription_item
            join product on subscription_item.product_id = product.id
            where subscription_item.subscription_id = ?;
            <sql:param value="${subscription.id}"/>
        </sql:query>

        <div class="panel panel-default">
            <div class="panel-heading">${subscription.id}-${subscription.subscription_date}</div>
            <div class="panel-body">
                <p>Termékek</p>
                <ul>
                    <c:forEach var="product" items="${products.rows}">
                        <li>${product.name} - ${product.quantity} csomag (${product.price_per_product} Forint)</li>
                    </c:forEach>
                </ul>

                <p>Következő szállítási nap: ${DateUtils.formatDateWithDayName(DeliveryUtils.getNextDeliveryDay(subscription.code))}</p>
                <p>Fizetendő: ${totalPrice.rows[0].total_price} Forint</p>
                <a href="${pageContext.request.contextPath}/customer-center/unsubscribe?id=${subscription.id}" class="btn btn-danger" role="button">
                    Előfizetés lemondása
                </a>
            </div>
        </div>
    </c:forEach>
</div>



</body>
