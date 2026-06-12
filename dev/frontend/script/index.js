function doLogin() {
    const userField = document.getElementById('login-user').value.trim();
    const passField = document.getElementById('login-pass').value.trim();
    const errorDiv = document.getElementById('login-error');


    errorDiv.style.display = 'none';

    if (userField === '' || passField === '') {
        errorDiv.innerText = 'Veuillez remplir tous les champs.';
        errorDiv.style.display = 'block';
        return;
    }

    const formData = new FormData();
    formData.append('username', userField);
    formData.append('password', passField);

    // Appelle login.php (qui est dans le même dossier 'pages' que login.html)
    fetch('login.php', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Le fichier login.php a renvoyé une erreur ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            // Stocke les infos de session dans le navigateur
            sessionStorage.setItem('user_prenom', data.prenom);
            sessionStorage.setItem('user_role', data.role);
            sessionStorage.setItem('show_welcome', 'true');

            // Redirige vers dashboard.html (qui est aussi dans le dossier 'pages')
            window.location.href = 'dashboard.php';
        } else {
            errorDiv.innerText = data.message;
            errorDiv.style.display = 'block';
        }
    })
    .catch(error => {
        console.error('Erreur détaillée:', error);
        errorDiv.innerText = 'Erreur réseau ou liaison : ' + error.message;
        errorDiv.style.display = 'block';
    });
}