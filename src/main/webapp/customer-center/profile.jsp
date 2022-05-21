<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/main.css">
  <title>Fiók adatok</title>
</head>
<body>

<%@include file="../fragments/navbar.jsp" %>

<script>
	
	function validateForm() {
		
		// TODO 8 karakter legalább és kis- és nagybetű + szám
		
		const password = document.getElementById('password').value;
		const passwordConfirm = document.getElementById('password-confirm').value;
		
		if (password !== passwordConfirm) {
			alert('A jelszó megerősítés nem sikerült!');
			return false;
		}
		
		return true;
	}
	
</script>

<h1>Profil adatok</h1>

<div>
    <h2>Személyes adatok szerkesztése</h2>
    <div>
        <form action="${pageContext.request.contextPath}/customer-center/update" method="post">
            <div>
                <label for="email">Email cím:</label>
                <input type="email" id="email" name="email" value="${fn:escapeXml(sessionScope.loggedInCustomer.email)}">
            </div>
            <div>
                <label for="name">Teljes név:</label>
                <input type="text" id="name" name="name" value="${fn:escapeXml(sessionScope.loggedInCustomer.name)}">
            </div>
            <input type="submit" value="Mentés">
        </form>
    </div>
</div>

<div>
    <h2>Jelszó megváltoztatása</h2>
    <div>
        <form action="${pageContext.request.contextPath}/customer-center/update-password" method="post" onsubmit="return validateForm()">
        		<c:if test="${param.invalidPassword}">
        			<div style="color: red;">
        				Nem sikerült a jelszó frissítése, mivel a régi jelszó megadása invalid.
        			</div>
        		</c:if>
        		<c:if test="${param.passwordUpdated}">
        			<div style="color: green;">
        				Sikeresen megváltoztatta a jelszót!
        			</div>
        		</c:if>
            <div>
                <label for="password">Új jelszó:</label>
                <input type="password" id="password" name="password" placeholder="Új jelszó">
            </div>
            <div>
                <label for="password-confirm">Új jelszó mégegyszer:</label>
                <input type="password" id="password-confirm" name="password-confirm" placeholder="Új jelszó mégegyszer">
            </div>
            <div>
                <label for="password-old">Régi jelszó megadása:</label>
                <input type="password" id="password-old" name="password-old" placeholder="Régi jelszó megadása">
            </div>
            <input type="submit" value="Jelszó megváltoztatása">
        </form>
    </div>
</div>

</body>
</html>