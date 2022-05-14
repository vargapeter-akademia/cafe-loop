<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Regisztráció</h1>

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


<form action="registration" onsubmit="return validateForm()" method="post">

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