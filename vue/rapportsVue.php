<?php
require_once("modele/interventionsModele.php");

if (!isset($_SESSION['idUser']) || $_SESSION['userType'] !== 'technicien') {
    echo "<div class='alert alert-danger'>Accès refusé. Réservé aux techniciens.</div>";
    return;
}

$modele = new interventionsModele();
$idTechnicien = $_SESSION['idUser'];
$message = "";

// Traitement de l'ajout d'un rapport
if (isset($_POST['submitRapport'])) {
    $idIntervention = isset($_POST['id_intervention']) ? $_POST['id_intervention'] : null;
    $contenuRapport = isset($_POST['rapport']) ? $_POST['rapport'] : "";
    $contenuNettoye = trim($contenuRapport);

    if ($idIntervention && !empty($contenuNettoye)) {
        $modele->createRapport($idTechnicien, $idIntervention, $contenuNettoye);
        $message = "<div class='alert alert-success'>Rapport ajouté avec succès.</div>";
    } else {
        $message = "<div class='alert alert-warning'>Veuillez remplir tous les champs.</div>";
    }
}

// Récupération des rapports existants
$rapports = $modele->selectRapportsByTechnicien($idTechnicien);

// Récupération des interventions affectées à ce technicien
$interventions = $modele->selectTechnicienIntervention($idTechnicien);
?>

<div class="container mt-5">
    <h2 class="text-center mb-4">Mes rapports d'intervention</h2>

    <?php echo $message; ?>

    <!-- Formulaire d'ajout de rapport -->
    <div class="card mb-4">
        <div class="card-header">Ajouter un nouveau rapport</div>
        <div class="card-body">
            <form method="post">
                <div class="mb-3">
                    <label for="id_intervention" class="form-label">Intervention concernée</label>
                    <select name="id_intervention" id="id_intervention" class="form-select" required>
                        <option value="">-- Choisir une intervention --</option>
                        <?php foreach ($interventions as $inter): ?>
                            <option value="<?php echo $inter['idIntervention']; ?>">
                                Intervention #<?php echo $inter['idIntervention']; ?> - <?php echo htmlspecialchars($inter['description']); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="rapport" class="form-label">Contenu du rapport</label>
                    <textarea name="rapport" id="rapport" rows="4" class="form-control" required></textarea>
                </div>

                <button type="submit" name="submitRapport" class="btn btn-primary">Ajouter le rapport</button>
            </form>
        </div>
    </div>

    <!-- Liste des rapports existants -->
    <?php if (empty($rapports)): ?>
        <div class="alert alert-info">Aucun rapport trouvé.</div>
    <?php else: ?>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID Rapport</th>
                    <th>ID Intervention</th>
                    <th>Contenu du rapport</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($rapports as $r): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($r['id']); ?></td>
                        <td><?php echo htmlspecialchars($r['id_intervention']); ?></td>
                        <td><?php echo nl2br(htmlspecialchars($r['rapport'])); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</div>
