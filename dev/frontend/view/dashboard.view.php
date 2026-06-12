<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style/style.css">
    <title>Gestion des paies - Tableau de bord</title>
</head>
<body>
    <div id="dashboard-page" class="dashboard-container">
        <h1 class="titre-principal">Gestion des paies</h1>
    </div>
    <div class="container">
        <div class="colone-un">
            <div class="profile">
                <p> <a href="dashboard.php">🖥️ Tableau de bord </a></p>
                <p> <a href="employes.php">👥 Gestion des employés </a></p>
                <p> <a href="contrats.php">📄 Gestion des contrats </a></p>
                <p> <a href="apprentis.php">💼 Gestion des apprentis </a></p>
            </div>
        </div>
        
        <div class="colone-deux">
            <div class="bg-tableau-titre">
                <h2>🪙 Tableau de bord</h2>
            </div>

            <div class="container-un">
                <div class="card">
                    <h3><?= htmlspecialchars($total_employes) ?></h3>
                    <p id="nombre-employes">Employés actifs</p>
                </div>
                <div class="card">
                    <h3><?= htmlspecialchars($total_contrats) ?></h3>
                    <p id="nombre-contrats">Nombre de contrats</p>
                </div>
                <div class="card">
                    <h3><?= htmlspecialchars($total_fiches) ?></h3>
                    <p id="nombre-fiches">Fiches générées</p>
                </div>
                <div class="card">
                    <h3><?= htmlspecialchars($total_apprentis) ?></h3>
                    <p id="nombre-apprentis">Apprentis</p>
                </div>
            </div>
            <!-- NOUVEAU : LISTE DES EMPLOYÉS ACTIFS DIRECTEMENT SUR LE DASHBOARD -->
            <div class="liste-employes dashboard-container-scroll">
                <h4>📋 Liste des employés actifs</h4>
                
                <div class="nav-employes header-table">
                    <div class="nom-employes"><strong>Nom</strong></div>
                    <div class="type-employes"><strong>TYPE</strong></div>
                    <div class="salaire-employes"><strong>SALAIRE</strong></div>
                    <div class="status-employes"><strong>STATUS</strong></div>
                </div>

                <?php foreach ($liste_employes_actifs as $employe): ?>
                    <div class="nav-employes ligne-employe">
                        <div class="nom-employes">
                            <?= htmlspecialchars($employe['prenom'] . ' ' . $employe['nom']) ?>
                        </div>
                       <div class="type-employes">
                         <?= htmlspecialchars($employe['type_contrat'] !== '' ? $employe['type_contrat'] : 'Apprenti') ?>
                        </div>
                        <div class="salaire-employes">
                            <?= number_format($employe['salaire_basse'], 2, '.', ' ') . ' CHF' ?>
                        </div>
                        <div class="status-employes">
                            <span class="status-badge actif">
                                <?= htmlspecialchars($employe['statut']) ?>
                            </span>
                        </div>
                    </div>
                <?php endforeach; ?>
                
                <?php if (empty($liste_employes_actifs)): ?>
                    <p style="padding: 10px; text-align: center;">Aucun employé actif trouvé.</p>
                <?php endif; ?>
            </div>

        </div>
    </div>

    <script src="../script/index.js"></script>
</body>
</html>