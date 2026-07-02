<?php
session_start();
session_destroy(); // Détruit toutes les données de connexion
header('Location: login.html'); // Redirige vers la page de login
exit;
?>