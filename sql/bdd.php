<?php

class BDD
{
    protected $bdd;

    public function __construct()
    {
        try {
            $this->bdd = new PDO('mysql:host=localhost;dbname=orange;charset=utf8', 'root', 'root');
            $this->bdd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Erreur de connexion à la base de données : " . $e->getMessage());
        }
    }

    public function getPDO()
    {
        return $this->bdd;
    }

    public function getHashKey()
    {
        $requete = "SELECT cle FROM cle_api WHERE id = 1";
        $stmt = $this->bdd->prepare($requete);
        $stmt->execute();
        $cle = $stmt->fetch();

        return isset($cle['cle']) ? $cle['cle'] : '';
    }
}
?>
