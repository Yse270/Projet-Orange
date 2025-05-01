<?php

class interventionsModele extends BDD
{
    public function __construct() 
    {
        parent::__construct();
    }

    public function createInterventions($dateInter, $duree, $statut, $description, $idMateriel)
    {
        $requete = "INSERT INTO intervention (date_inter, duree, statut, description, idMateriel, idtechnicien)
                    VALUES (:dateInter, :duree, :statut, :description, :idMateriel, :idtechnicien)";
                    
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":dateInter", $dateInter);
        $select->bindParam(":duree", $duree);
        $select->bindParam(":statut", $statut);
        $select->bindParam(":description", $description);
        $select->bindParam(":idMateriel", $idMateriel);
        $select->bindParam(":idtechnicien", $_SESSION['idUser']);

        $select->execute();
    }
    

    public function updateInterventions($dateInter, $duree, $statut, $description, $idMateriel, $idIntervention)
    {
        $requete = "UPDATE intervention 
                    SET date_inter = :dateInter, duree = :duree, statut = :statut, 
                        description = :description, idMateriel = :idMateriel 
                    WHERE idIntervention = :idIntervention";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":dateInter", $dateInter);
        $select->bindParam(":duree", $duree);
        $select->bindParam(":statut", $statut);
        $select->bindParam(":description", $description);
        $select->bindParam(":idMateriel", $idMateriel);
        $select->bindParam(":idIntervention", $idIntervention);
        $select->execute();
    }

    public function deleteIntervention($idIntervention)
    {
        $requete = "DELETE FROM intervention WHERE idIntervention = :idIntervention";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":idIntervention", $idIntervention);
        $select->execute();
    }

    public function selectClientIntervention($idUser)
    {
        $requete = "SELECT i.idIntervention, i.date_inter, i.duree, i.statut, i.description, i.idMateriel
                    FROM intervention AS i
                    WHERE idtechnicien = :idUser";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":idUser", $idUser);
        $select->execute();
        return $select->fetchAll();
    }

    public function selectTechnicienIntervention($idUser)
    {
        $requete = "SELECT * FROM intervention WHERE idTechnicien = :idUser";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":idUser", $idUser);
        $select->execute();
        return $select->fetchAll();
    }

    public function searchIntervention($mot)
    {
        $requete = "SELECT * FROM intervention 
                    WHERE date_inter LIKE :mot OR duree LIKE :mot OR statut LIKE :mot OR description LIKE :mot";
        $select = $this->bdd->prepare($requete);
        $mot = "%" . $mot . "%";
        $select->bindParam(":mot", $mot);
        $select->execute();
        return $select->fetchAll();
    }

    public function selectWhereIntervention($idIntervention)
    {
        $requete = "SELECT * FROM intervention WHERE idIntervention = :idIntervention";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":idIntervention", $idIntervention);
        $select->execute();
        return $select->fetch();
    }

    public function selectClientMaterials($idClient)
    {
        $requete = "SELECT idMateriel FROM materiel WHERE idUser = :idClient";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":idClient", $idClient);
        $select->execute();
        return $select->fetchAll();
    }

    public function createMateriel($nom, $idUser)
    {
        $requete = "INSERT INTO materiel (nom, idUser) VALUES (:nom, :idUser)";
        $stmt = $this->bdd->prepare($requete);
        $stmt->bindParam(":nom", $nom);
        $stmt->bindParam(":idUser", $idUser);
        $stmt->execute();
    }

    public function createRapport($idTechnicien, $idIntervention, $rapport)
    {
        $sql = "INSERT INTO rapports (id_technicien, id_intervention, rapport) VALUES (?, ?, ?)";
        $stmt = $this->bdd->prepare($sql);
        $stmt->execute(array($idTechnicien, $idIntervention, $rapport));
    }

    public function selectRapportsByTechnicien($idTechnicien)
    {
        $sql = "SELECT * FROM rapports WHERE id_technicien = ?";
        $stmt = $this->bdd->prepare($sql);
        $stmt->execute(array($idTechnicien));
        return $stmt->fetchAll();
    }

    public function deleteRapport($idRapport)
    {
        $sql = "DELETE FROM rapports WHERE id = ?";
        $stmt = $this->bdd->prepare($sql);
        $stmt->execute(array($idRapport));
    }
}
?>
