<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>


<c:choose>
    <%-- Van bejelentkezett felhasználó --%>
    <c:when test="${sessionScope.customer != null}">
        <h1>Üdvözöljük <c:out value="${sessionScope.customer.name}"/>! </h1>
    </c:when>
    <%-- Nincs bejelentkezett felhasználó --%>
    <c:otherwise>
        <h1>Üdvözöljük!</h1>
    </c:otherwise>
</c:choose>

<ul>
    <c:choose>
        <%-- Van bejelentkezett felhasználó --%>
        <c:when test="${sessionScope.customer != null}">
            <li><a href="customer-center/profile.jsp">Profil adatok</a></li>
            <li><a href="customer-center/subsciptions.jsp">Előfizetések</a></li>
            <li><a href="customer-center/new-subscription.jsp">Új előfizetés</a></li>
            <a href="${pageContext.request.contextPath}/customer-center/logout">Kijelentkezés</a>
        </c:when>
        <%-- Nincs bejelentkezett felhasználó --%>
        <c:otherwise>
            <a href="registration.jsp">Regisztráció</a>
            <a href="login.jsp">Bejelentkezés</a>
        </c:otherwise>
    </c:choose>
</ul>

</body>
</html>