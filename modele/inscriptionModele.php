<?php

class inscriptionModele extends BDD
{
    private $inscription;
    private $hash;

    public function __construct()
    {
        parent::__construct();
        $this->hash = parent::getHashKey(); // récupération de la clé de hachage
    }

    public function insertUser($tab)
    {
        // 🔐 Hachage du mot de passe avant insertion
        $tab['mdp'] = sha1($tab['mdp'] . $this->hash['cle']);

        // ✅ Choix de la procédure selon le rôle
        if ($tab['role'] === 'client') {
            $requete = "CALL insererClient(:nom, :prenom, :adresse, :telephone, :email, :mdp, :role, '1');";
        } elseif ($tab['role'] === 'technicien') {
            $requete = "CALL insererTechnicien(:nom, :prenom, :adresse, :telephone, :email, :mdp, :role, '1');";
        } else {
            throw new Exception("Rôle inconnu : " . $tab['role']);
        }

        $select = $this->bdd->prepare($requete);
        $select->bindValue(":nom", $tab['nom']);
        $select->bindValue(':prenom', $tab['prenom']);
        $select->bindValue(':adresse', $tab['adresse']);
        $select->bindValue(':telephone', $tab['telephone']);
        $select->bindValue(':email', $tab['email']);
        $select->bindValue(':mdp', $tab['mdp']);
        $select->bindValue(':role', $tab['role']);

        $select->execute();
    }

    public function existingUser($email)
    {
        $requete = "SELECT * FROM users AS u WHERE u.email = :email;";
        $select = $this->bdd->prepare($requete);
        $select->bindParam(":email", $email);

        $select->execute();
        return $select->fetch();
    }

    // Getter
    public function getHash()
    {
        return $this->hash;
    }
}
?>
