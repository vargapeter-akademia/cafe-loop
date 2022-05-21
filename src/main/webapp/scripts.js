

function validatePassword() {

    // TODO 8 karakter legalább és kis- és nagybetű + szám

    const password = document.getElementById('password').value;
    const passwordConfirm = document.getElementById('password-confirm').value;

    if (password !== passwordConfirm) {
        alert('A jelszó megerősítés nem sikerült!');
        return false;
    }

    return true;
}