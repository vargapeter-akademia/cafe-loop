<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<h1>Bejelentkezés</h1>

<div>
    <form action="login" method="post">

        <div>
            <label for="email">Email cím: </label>
            <input id="email" name="email" value="${param.email == null ? '' : param.email}">
        </div>
        <div>
            <label for="email">Jelszó: </label>
            <input id="password" name="password" type="password">
        </div>

        <div>
            <button type="submit">Bejelentkezés</button>
        </div>
    </form>
</div>

</body>
</html>