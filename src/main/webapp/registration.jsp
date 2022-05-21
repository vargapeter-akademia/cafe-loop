<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Regisztráció</title>
    <script src="scripts.js"></script>
</head>
<body>

<h1>Regisztráció</h1>

<form action="registration" onsubmit="return validatePassword()" method="post">

    <div>
        <label>Email: </label><input name="email" type="email">
    </div>

    <div>
        <label>Teljes név: </label><input name="name" type="text">
    </div>

    <div>
        <label>Jelszó: </label><input id="password" name="password" type="password">
    </div>

    <div>
        <label>Jelszó megerősítés: </label><input id="password-confirm" name="password-confirm" type="password">
    </div>

    <input type="submit" value="Regisztráció">

</form>


</body>
</html>