<%@ page import="hu.ak.generics.cafeloop.util.DeliveryUtils" %>
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
    select subscription.id as id, subscription_date, address, frequency.code as frequency_code
    from subscription
    join frequency on subscription.frequency_id = frequency.id
    where customer_id = ?;
    <sql:param value="${sessionScope.loggedInCustomer.id}"/>
</sql:query>

<div class="container container-fluid">
    <ul class="list-group">
        <c:forEach var="subscription" items="${subscriptions.rows}">
            <jsp:useBean id="deliveryUtils" scope="session" type="hu.ak.generics.cafeloop.util.DeliveryUtils"/>

            <sql:query var="products" dataSource="jdbc/mysql">
                select product.name, subscription_item.quantity
                from subscription_item
                join product on product.id = subscription_item.product_id
                where subscription_id = ?;
                <sql:param value="${subscription.id}"/>
            </sql:query>

            <p>Termékek</p>
            <li class="list-group-item">
                <h3>${subscription.subscription_date}</h3>
                <ul>
                    <c:forEach var="product" items="${products.rows}">
                        <li>${product.name} - ${product.quantity} csomag</li>
                    </c:forEach>
                </ul>
            </li>

            <p>Következő szállítási napok</p>
            <ul>
                ${deliveryUtils.getNextDeliveryDay(subscription.frequency_code)}
            </ul>

        </c:forEach>
    </ul>
</div>



</body>
