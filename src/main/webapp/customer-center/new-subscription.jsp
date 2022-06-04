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
    <img src="${pageContext.request.contextPath}/images/logo-big.png" class="img-responsive img-circle" style="display:inline;" width="150" height="150">
    <h2>Új előfizetés</h2>
</div>

<div class="container container-fluid">

	<sql:query var="products" dataSource="jdbc/mysql">
		select id, name, price, description, image_path from product;
	</sql:query>
			
	<h2>Termékek kiválasztása</h2>
			
	<div class="panel panel-default">
		<div class="panel-body">
		
			<c:forEach items="${products.rows}" var="product">
			
				<form action="select-product" method="get">
					
					<h3>${product.name}</h3>
					<p>${product.description}</p>
					
					<div class="input-group">
						<span class="input-group-addon">Mennyiség</span>
					  <input class="form-control" type="number" name="quantity" value="${sessionScope.selectedProducts.get(product.id)}">
					  <input name="productId" value="${product.id}" hidden>
					</div><br>
					
					<button type="submit" class="btn btn-lg btn-block bg-1" title="">Termék kiválasztása</button>
					
				</form>
			
			</c:forEach>
			
		</div>
	</div>
	

<form action="new-subscription" method="post">
	
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="input-group">
				<span class="input-group-addon">Cím</span>
				<input class="form-control" name="address" required placeholder="1027. Budapest Gipsz Jakab utca 4.">
			</div><br>
			
			<sql:query var="frequencies" dataSource="jdbc/mysql">
				select id, name from frequency;	
			</sql:query>
			
			<div class="input-group">
				<span class="input-group-addon">Szállítás gyakorisága</span>
			  <select class="form-control" name="frequencyId">
			  	<c:forEach items="${frequencies.rows}" var="freq">
			    	<option value="${freq.id}">${freq.name}</option>
			    </c:forEach>
			  </select>
			</div><br>
				
			<button type="submit" class="btn btn-lg btn-block bg-1" title="">Új előfizetés elküldése</button>
			</div>
		</div>
</form>


</div>

</body>
</html>