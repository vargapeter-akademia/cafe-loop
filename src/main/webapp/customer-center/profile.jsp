<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Fiók adatok</title>
</head>
<body>

<h1>Profil adatok</h1>

<div>
    <h2>Személyes adatok szerkesztése</h2>
    <div>
        <form action="${pageContext.request.contextPath}/customer-center/update" method="post">
            <div>
                <label for="email">Email cím:</label>
                <input type="email" id="email" name="email" value="${fn:escapeXml(sessionScope.customer.email)}">
            </div>
            <div>
                <label for="name">Teljes név:</label>
                <input type="text" id="name" name="name" value="${fn:escapeXml(sessionScope.customer.name)}">
            </div>
            <input type="submit" value="Mentés">
        </form>
    </div>
</div>

<div>
    <h2>Jelszó megváltoztatása</h2>
    <div>
        <form action="${pageContext.request.contextPath}/customer-center/update-password" method="post" onsubmit="return validatePassword()">
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
