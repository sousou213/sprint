<?php

require_once('modele/modele.php');
require_once('vue/vue.php');

function CtlAcceuil(){
    afficherAcceuil();
} 

function CtlMedecin ($nom,$spe){
    if(isset($_POST['verification']) and !empty($_POST['nommedecin']) and !empty($_POST['specialite'])){
        $nom=$_POST['nommedecin'];
        $spe=$_POST['specialite'];
        $medecin=getIdMedecin($nom, $spe);
        if ($medecin != null){
            echo '<script> alert("correspond") </script>';
        }
        else{
            echo '<script> alert("faux") </script>';
        }
    }
}

//function CtlReserver($nom, $spe, $date, $heure){
  //  if(isset($_POST['reserver']) and !empty($_POST['daterdv']) !empty($_POST['heurerdv']) and CtlMedecin($nom, $spe)){


    //}
//}

function CtlMotif(){
    if(isset($_POST['verification'])){
        $motif=getMotif();
        afficherMotif($motif);
    }
}

function CtlConnect ($login, $mdp){
    if(isset($_POST['connexion']) and !empty($_POST['user']) and !empty($_POST['mdp'])){
        $login=$_POST['user'];
        $mdp=$_POST['mdp'];
        $cate=checkCategorie($login, $mdp);

        $pseudo=checkEmploye($login, $mdp);
        foreach($cate as $verif){
            if($verif[0]=="médecin" and $pseudo!=null){
                afficherMedecin();
            }
            else if ($verif[0] == "agent" and $pseudo!=null){
                afficherAgent();
            }
            else if($verif[0]=="directeur"and $pseudo!=null){
                afficherDirecteur();
            }
            else {
                throw new Exception ("login ou mdp incorrect !");
            }
        }
    }
    else {
        throw new Exception ("login ou mdp vide.");
    }


}
function CtlIdMedecin($nom, $spe){
    if(isset($_POST['getID']) and !empty($_POST['nommed']) and !empty($_POST['spemed'])){
        $nom=($_POST['nommed']);
        $spe=($_POST['spemed']);
        $id=getIdMedecin($nom, $spe);
        afficherIDMedecin($id);
    }
    else {
        throw new Exception('erreur');
    }
}

function CtlErreur($erreur){
    afficherErreur($erreur, "gabaritConnect.php");
}

function CtlRecupNss($nom, $date){
    if (isset($_POST['recuperer']) and !empty($_POST['name']) and !empty($_POST['Date'])){
        $nom=$_POST['name'];
        $date=$_POST['Date'];
        $nss=getNSS($nom, $date);
        afficherNSS($nss);
    }
    else {
        throw new Exception('erreur');
    }
}

function CtlSynthesePatient($nss){
    if(isset($_POST['saisir']) and !empty($_POST['num'])){
        $nss=$_POST['num'];
        $synthese=getSynthese($nss);
        afficherSynthese($synthese);
        $statut=getStatutRdvNonPayer($nss);
        $liste=RdvNonPayer($nss, $statut);
        afficherListeRdv($liste);
    }
    else {
        throw new Exception('erreur');
    }
}

function CtlDepot($nss, $montant){
    if(isset($_POST['ajouter']) and !empty($_POST['num']) and !empty($_POST['montant'])){
        $nss=$_POST['num'];
        $montant=$_POST['montant'];
        depot($nss, $montant);
        afficherAgent();
    }
    else {
        throw new Exception('erreur');
    }
}

function CtlAfficherInformationsPatient($nss){
    if(isset($_POST['monter']) and !emty($_POST['information'])){
        $nss=$_POST['information'];
        $synthese=getSynthese($nss);
    }
}


function CtlAjoutPatient($nom,$prenom,$adresse,$numtel,$datenaissance,$depnaissance,$solde){
    if(!empty($prenom) and !empty($nom) and !empty($adresse) and !empty($numtel) and 
    !empty($datenaissance) and !empty($depnaissance) and !empty($solde) and
    isset($_POST['creerpatient']) ){
        $prenom=$_POST['prenom'];
        $nom=$_POST['nom'];
        $adresse=$_POST['adresse'];
        $numtel=$_POST['numero'];
        $datenaissance=$_POST['naissance'];
        $depnaissance=$_POST['departement'];
        $solde=$_POST['solde'];
        ajouterPatient($nom,$prenom,$adresse,$numtel,$datenaissance,$depnaissance,$solde);
    }
    else{
        throw new Exception("un champ est vide");
        }
    
}

function CtlAjoutPatientEtranger($nom,$prenom,$adresse,$numtel,$datenaissance,$depnaissance,$pays,$solde){
    if(!empty($prenom) and !empty($nom) and !empty($adresse) and !empty($numtel) and 
    !empty($datenaissance) and !empty($depnaissance) and !empty($pays) and !empty($solde) and
    isset($_POST['creerpatient']) ){
        $prenom=$_POST['prenom'];
        $nom=$_POST['nom'];
        $adresse=$_POST['adresse'];
        $numtel=$_POST['numero'];
        $datenaissance=$_POST['naissance'];
        $depnaissance=$_POST['departement'];
        $pays=$_POST['Pays'];
        $solde=$_POST['solde'];
        ajouterPatientEtranger($nom,$prenom,$adresse,$numtel,$datenaissance,$depnaissance,$pays,$solde);
    }
    else{
        throw new Exception("un champ est vide");
        }
}


function CtlAjoutCompte($login, $idcate, $mdp){
    if(!empty($login) and !empty($idcate) and !empty($mdp) and
    isset($_POST['Creercompte'])){
        $login=$_POST['pseudo'];
        $mdp=$_POST['pass'];
        $idcate=$_POST['cat'];
        ajouterCompte ($login, $idcate, $mdp);
    }
    else{
        throw new Exception("compte non ajouté");
    }
}

function CtlAjoutMotif($motifrdv, $piece, $consigne, $prix){
    if(!empty($motifrdv) and !empty($piece) and !empty($consigne) and !empty($prix) and isset($_POST['creermotif'])){
        $motifrdv=$_POST['motif'];
        $prix=$_POST['prix'];
        $piece=$_POST['pieceafournir'];
        $consigne=$_POST['consigne'];
        ajouterIntervention($motifrdv, $piece, $consigne, $prix);
    }
    else{
        throw new Exception("motif non ajouté");
    }
}

function CtlAjoutRDV($nomMedecin,$specialite,$date,$heure){
    if(!empty($nomMedecin) and !empty($specialite) and !empty($date) and !empty($heure) and isset($_POST['creerRDV'])){
        $nomMedecin=$_POST['nomMedecin'];
        $specialite=$_POST['specialite'];
        $date=$_POST['date'];
        $heure=$_POST['heure'];

    }
    else{
        throw new Exception("RDV non ajouter")
    }
}


function CtlSuppMotif($motif){
    if(!empty($motif) and isset($_POST['supprimermotif'])){        
        $motif=$_POST['nommotif'];
        supprimerMotif($motif);
    }

    else{
        throw new Exception("motif non supprimé");
    }

}

function CtlSuppMedecin($login,$mdp,$nom, $prenom, $specialite){
    if(!empty($nom) and !empty($prenom) and !empty($specialite) and isset($_POST['supprimermedecin'])){
        $nom=$_POST['nommedecin'];
        $prenom=$_POST['prenommedecin'];
        $specialite=$_POST['specialitemedecin'];
        $login=$_POST['pseudo'];
        $mdp=$_POST['pass'];
        supprimerMedecin($nom, $prenom, $specialite);
        supprimerEmploye($login, $mdp);
    }
    else{
        throw new Exception("médecin non supp");
    }
}

function CtlAjoutMedecin($categorie,$nommedecin,$prenommedecin,$specialitemedecin){
    if(!empty($nommedecin) and !empty($prenommedecin) and !empty($categorie) and !empty($specialitemedecin) and isset($_POST['Creercompte'])){
        $categorie=$_POST['cat'];
        $nommedecin=$_POST['nommedecin'];
        $prenommedecin=$_POST['prenommedecin'];
        $specialitemedecin=$_POST['specialitemedecin'];
        ajouterMedecin ($categorie, $nommedecin, $prenommedecin, $specialitemedecin);
    }
    else{
        throw new Exception ('médecin non ajouté');
    }
}

function CtlRdvNonPayer($nss){
    if(isset($_POST['afficherpayement']) and !empty($_POST['num2'])){
        $nss=$_POST['num2'];
        $statut=getStatutRdvNonPayer($nss);
        RdvNonPayer($nss, $statut);
    }
    else {
        throw new Exception('erreur');
    }
}

function CtlDeconnect(){
    if (isset($_POST['deconnexion'])){
       CtlAcceuil();
    }
}
//a finir
function Ctlbloquer($id, $libelle, $date, $heure){
    if(isset($_POST['valider_creneaux']) and !empty($id) and !empty($libelle) and !empty($date) and !empty($heure)){
        bloquerCreneau($id, $libelle, $date, $heure);
    }
    else {
        throw new Exception ('pas disponible');
    }
}

function CtlModifierRdv($motif,$prix,$piece){
    if(isset($_POST['modifier'] and !empty($_POST['motif']) and !empty($_POST['prix'] and !empty($_POST['piece'])){
        $motif=$_POST['motif'];
        $prix=$_POST['prix'];
        $piece=$_POST['piece'];
        function modifierMotif($motifRdv, $prix, $pieces);
    }
    else{
        throw new Exception('erreur')
    }


    }
}



