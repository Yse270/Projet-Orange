<?php
if (isset($_SESSION['email'])) {
    require_once("controleur/interventionControleur.php");
    $ctrl = new interventionControleur();

    // Initialiser les variables pour éviter les erreurs
    if (!isset($formIntervention)) $formIntervention = null;
    if (!isset($lesInterventions)) $lesInterventions = $ctrl->selectClientIntervention($_SESSION['idUser']);
    if (!isset($lesMateriaux)) $lesMateriaux = $ctrl->selectClientMaterials($_SESSION['idUser']);
?>
<br>
<h2 class="text-center">Interventions</h2>
<br>

<!-- ✅ Ajout d'un matériel (visible uniquement pour les clients) -->
<?php
if ($_SESSION['userType'] === "client") { ?>
    <h5>Ajouter un matériel</h5>
    <form method="post" class="mb-4">
        <div class="form-group mb-2">
            <input type="text" class="form-control" name="nomMateriel" placeholder="Nom du matériel" required>
        </div>
        <button type="submit" name="createMateriel" class="btn btn-secondary">Ajouter le matériel</button>
    </form>
<?php }

 if (isset($_POST["createIntervention"])) {
    $ctrl->createInterventions(
        $_POST['dateInter'],
        $_POST['duree'],
        $_POST['statut'],
        $_POST['description'],
        $_POST['idMateriel']
    );
    echo '<script>window.location.href="index.php?page=2";</script>';
    exit;
}

?>

<!-- 🛠 Formulaire pour intervention -->
<?php if ($_SESSION['userType'] === "client" || $_SESSION['userType'] === "technicien") { ?>
    <form method="post">
        <div class="form-group">

            <div class="form-floating mb-3">
                <input type="date" name="dateInter" class="form-control"
                       value="<?= ($formIntervention != null) ? $formIntervention['date_inter'] : '' ?>"
                    <?= ($_SESSION['userType'] === "technicien" && $formIntervention != null) ? 'readonly' : '' ?>>
                <label>Date Intervention</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" name="duree" class="form-control"
                       value="<?= ($formIntervention != null) ? $formIntervention['duree'] : '' ?>"
                    <?= ($_SESSION['userType'] === "technicien" && $formIntervention != null) ? 'readonly' : '' ?>>
                <label>Durée</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" name="statut" class="form-control"
                       value="<?= ($formIntervention != null) ? $formIntervention['statut'] : '' ?>"
                    <?= ($_SESSION['userType'] === "technicien" && $formIntervention != null) ? 'readonly' : '' ?>>
                <label>Statut</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" name="description" class="form-control"
                       value="<?= ($formIntervention != null) ? $formIntervention['description'] : '' ?>"
                    <?= ($_SESSION['userType'] === "technicien" && $formIntervention != null) ? 'readonly' : '' ?>>
                <label>Description</label>
            </div>

            <div class="mb-3">
                <select name="idMateriel" class="form-select" required
                    <?= ($_SESSION['userType'] === "technicien" && $formIntervention != null) ? 'disabled' : '' ?>>
                    <option value="">-- Choisir un matériel --</option>
                    <?php
                    if (!empty($lesMateriaux)) {
                        
                        foreach ($lesMateriaux as $unMateriel) {
                            $id = $unMateriel['idMateriel'];
                            $selected = ($formIntervention != null && $formIntervention['idMateriel'] == $id) ? 'selected' : '';
                            echo '<option value="' . $id . '" ' . $selected . '>Matériel #' . $id . '</option>';
                        }
                    }
                    ?>
                </select>
            </div>

            <input type="hidden" name="idtechnicien" value="<?= $_SESSION['idUser']; ?>">

            <?php if ($formIntervention != null) { ?>
                <button type="submit" class="btn btn-warning" name="modifyIntervention">Modifier Intervention</button>
            <?php } else { ?>
                <button type="submit" class="btn btn-success" name="createIntervention">Créer Intervention</button>
            <?php } ?>
        </div>
    </form>
<?php } ?>

<br><br>

<!-- 📋 Liste des interventions -->
<table class="table table-bordered">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Durée</th>
            <th>Statut</th>
            <th>Description</th>
            <th>Matériel</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php
        
        if (!empty($lesInterventions)) {
            foreach ($lesInterventions as $uneIntervention) { ?>
                <tr>
                    <td><?= $uneIntervention['idIntervention'] ?></td>
                    <td><?= $uneIntervention['date_inter'] ?></td>
                    <td><?= $uneIntervention['duree'] ?></td>
                    <td><?= $uneIntervention['statut'] ?></td>
                    <td><?= $uneIntervention['description'] ?></td>
                    <td><?= $uneIntervention['idMateriel'] ?></td>
                    <td>
                        <a href="index.php?page=2&action=modifier&idIntervention=<?= $uneIntervention['idIntervention'] ?>">
                            <img src="images/modifier.png" width="30" height="30" alt="Modifier">
                        </a>
                        <a href="index.php?page=2&action=supprimer&idIntervention=<?= $uneIntervention['idIntervention'] ?>" onclick="return confirm('Supprimer cette intervention ?');">
                            <img src="images/supprimer.png" width="30" height="30" alt="Supprimer">
                        </a>
                    </td>
                </tr>
        <?php }
        } else { ?>
            <tr><td colspan="7" class="text-center">Aucune intervention trouvée.</td></tr>
        <?php } ?>
    </tbody>
</table>

<?php
} else {
    echo '<div class="alert alert-warning text-center">Veuillez vous connecter pour accéder aux interventions.</div>';
}
?>
