<?php
// Désactiver l'affichage des erreurs brutes à l'écran pour éviter de casser le JSON
ini_set('display_errors', 0);
error_reporting(E_ALL);

session_start();
header('Content-Type: application/json; charset=utf-8');

if (!isset($_POST['username']) || !isset($_POST['password'])) {
    echo json_encode(['success' => false, 'message' => 'Veuillez remplir tous les champs.']);
    exit;
}

$username = trim($_POST['username']);
$password = trim($_POST['password']);

try {
    // Tentative de connexion à la base de données
    $db = new PDO(
        'mysql:host=localhost;dbname=gestions_des_paies_bismellah_hashimi_2026;charset=utf8', 
        'root', 
        ''
    );
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Requête SQL
    $stmt = $db->prepare('SELECT id_utilisateur, nom, prenom, mot_de_passe, role, statut FROM t_utilisateur WHERE nom = :nom LIMIT 1');
    $stmt->execute(['nom' => $username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        // Accepte le mot de passe s'il est haché OU s'il est en clair (pratique pour vos tests)
        $passwordCorrect = password_verify($password, $user['mot_de_passe']) || ($password === $user['mot_de_passe']);

        if ($passwordCorrect) {
            if (strtolower($user['statut']) === 'inactif') {
                echo json_encode(['success' => false, 'message' => 'Votre compte est inactif.']);
                exit;
            }

            // Stockage en session
            $_SESSION['user_id'] = $user['id_utilisateur'];
            $_SESSION['user_nom'] = $user['nom'];
            $_SESSION['user_prenom'] = $user['prenom'];
            $_SESSION['user_role'] = $user['role'];

            echo json_encode([
                'success' => true,
                'prenom' => $user['prenom'],
                'role' => $user['role']
            ]);
            exit;
        }
    }

    // Message standard en cas d'échec pour des raisons de sécurité
    echo json_encode(['success' => false, 'message' => 'Identifiant ou mot de passe incorrect.']);
    exit;

} catch (PDOException $e) {
    // Si la base de données crash, on renvoie proprement du JSON plutôt qu'un écran d'erreur PHP
    echo json_encode([
        'success' => false,
        'message' => 'Erreur de base de données : ' . $e->getMessage()
    ]);
    exit;
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Erreur système : ' . $e->getMessage()
    ]);
    exit;
}