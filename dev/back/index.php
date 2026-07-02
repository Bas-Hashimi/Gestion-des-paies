<?php
session_start();

// Si l'utilisateur n'est pas connecté, on le redirige vers la page de login HTML
if (!isset($_SESSION['user_id'])) {
    header('Location: login.html'); // Remplacez par le nom exact de votre fichier HTML de login
    exit;
}

// 1. Connexion à la base de données
try {
    $db = new PDO(
        'mysql:host=localhost;dbname=gestions_des_paies_bismellah_hashimi_2026;charset=utf8', 
        'root', 
        ''
    );
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $e) {
    die('Erreur de connexion : ' . $e->getMessage());
}

// 2. Requête SQL pour récupérer les employés
$requete = "SELECT 
                u.id_utilisateur,
                u.nom, 
                u.prenom,
                c.type_contrat, 
                c.salaire_basse, 
                u.statut
            FROM t_utilisateur u
            INNER JOIN t_contrat c ON u.id_utilisateur = c.id_utilisateur
            WHERE c.annee_apprentissage IS NULL";

$resultat = $db->query($requete);
$liste_employes = $resultat->fetchAll(PDO::FETCH_ASSOC);

// 3. Inclure la vue
include 'employes.view.php';