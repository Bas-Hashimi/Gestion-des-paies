<?php
session_start();

// Si l'utilisateur n'est pas connecté, redirection vers le login
if (!isset($_SESSION['user_id'])) {
    header('Location: login.html');
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

// 2. Requêtes SQL pour récupérer les compteurs réels
$total_employes = $db->query("SELECT COUNT(*) FROM t_utilisateur WHERE LOWER(statut) = 'actif'")->fetchColumn();
$total_contrats = $db->query("SELECT COUNT(*) FROM t_contrat")->fetchColumn();
$total_fiches = $db->query("SELECT COUNT(*) FROM t_fiche_paie")->fetchColumn();
$total_apprentis = $db->query("SELECT COUNT(*) FROM t_contrat WHERE annee_apprentissage IS NOT NULL")->fetchColumn();

// 3. NOUVEAU : Requête SQL pour récupérer TOUS les employés ACTIFS
$requete_actifs = "SELECT 
                    u.id_utilisateur,
                    u.nom, 
                    u.prenom,
                    c.type_contrat, 
                    c.salaire_basse, 
                    u.statut
                FROM t_utilisateur u
                INNER JOIN t_contrat c ON u.id_utilisateur = c.id_utilisateur
                WHERE LOWER(u.statut) = 'actif'";

$resultat_actifs = $db->query($requete_actifs);
$liste_employes_actifs = $resultat_actifs->fetchAll(PDO::FETCH_ASSOC);

// 4. Inclure la vue
include 'dashboard.view.php';
?>