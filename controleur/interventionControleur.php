<?php
require_once("modele/interventionsModele.php");

class interventionControleur
{
    private $interventionModele;

    public function __construct()
    {
        $this->interventionModele = new interventionsModele();
    }

    // 🔧 CRUD Interventions

    public function createInterventions($dateInter, $duree, $statut, $description, $idMateriel)
    {
        $this->interventionModele->createInterventions($dateInter, $duree, $statut, $description, $idMateriel);
    }

    public function updateInterventions($dateInter, $duree, $statut, $description, $idMateriel, $idIntervention)
    {
        $this->interventionModele->updateInterventions($dateInter, $duree, $statut, $description, $idMateriel, $idIntervention);
    }

    public function deleteIntervention($idIntervention)
    {
        $this->interventionModele->deleteIntervention($idIntervention);
    }

    public function selectWhereIntervention($idIntervention)
    {
        return $this->interventionModele->selectWhereIntervention($idIntervention);
    }

    public function searchIntervention($mot)
    {
        return $this->interventionModele->searchIntervention($mot);
    }

    // 📋 Liste des interventions par rôle

    public function selectClientIntervention($idUser)
    {
        return $this->interventionModele->selectClientIntervention($idUser);
    }

    public function selectTechnicienIntervention($idUser)
    {
        return $this->interventionModele->selectTechnicienIntervention($idUser);
    }

    // 🧱 Gestion des matériels

    public function selectClientMaterials($idClient)
    {
        return $this->interventionModele->selectClientMaterials($idClient);
    }

    public function createMateriel($nom, $idUser)
    {
        $this->interventionModele->createMateriel($nom, $idUser);
    }

    // 📄 Rapports

    public function createRapport($idTechnicien, $idIntervention, $rapport)
    {
        $this->interventionModele->createRapport($idTechnicien, $idIntervention, $rapport);
    }

    public function getRapportsByTechnicien($idTechnicien)
    {
        return $this->interventionModele->selectRapportsByTechnicien($idTechnicien);
    }

    public function deleteRapport($idRapport)
    {
        $this->interventionModele->deleteRapport($idRapport);
    }
}
?>
