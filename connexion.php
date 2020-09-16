<?php

class Connexion
{
    
    
     => Connecter un utilisateur :
    $TEXTE_connexion = "";
    if (isset($_POST["email"]) && isset($_POST["password"]))
    {
        //On execute la fonction connexion qui renvoie true ou false
        $validation = Utilisateur::connexion($_POST["email"], $_POST["password"], "membre");
        if(!$validation){// Si la connexion a échoué on l'indique en rajoutant un texte près du module
            $TEXTE_connexion = "Email inexistant ou mot de passe invalide";
        }
    }
    
    =>Un fois connecté :
    //# Si le membre est connecté on créer son objet (le membre est connecté quand la variable de session existe, voir fonction Utilisateur::connexion )
    if(isset($_SESSION['membre'])){
        $leMembre = new Utilisateur($_SESSION['membre']);
        //print_r($leMembre);
    }
    
		    
=> Changer le nom de l'utilisateur :
$leMembre->setPrenom($_POST['prenom']);
$retour = $leMembre->sauvegarderLUtilisateur();
if(!$retour)
    $TEXTE_compte .= "ECHEC de la sauvegarde des modifications.";
    
    => Supprimer un utilisateur :
    if(!Utilisateur::supprimerLUtilisateur($_GET['suppmbr']))
        $TEXTE_admin = "Erreur à la suppression du membre.<br/>";
        
        => Inscrire un utilisateur :
        Utilisateur::inscription($_POST['email'], $_POST['motDePasse'], $_POST['nom'], $_POST['prenom']);
}
?>
