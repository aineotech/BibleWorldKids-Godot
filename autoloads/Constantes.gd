extends Node
# Autoload "Constantes" — zéro magic string dans tout le projet.

# --- Scènes ---
const SCENE_BOOT        := "res://_Game/Scenes/Boot.tscn"
const SCENE_MENU        := "res://_Game/Scenes/MenuPrincipal.tscn"
const SCENE_CREATEUR    := "res://_Game/Scenes/CreateurAvatar.tscn"
const SCENE_CARTE       := "res://_Game/Scenes/CarteDuMonde.tscn"
const SCENE_CHARGEMENT  := "res://_Game/Scenes/EcranChargement.tscn"
const SCENE_VILLAGE     := "res://_Game/Scenes/Lieu_Village.tscn"
const SCENE_ARCHE       := "res://_Game/Scenes/Lieu_Arche.tscn"
const SCENE_JARDIN      := "res://_Game/Scenes/Lieu_Jardin.tscn"
const SCENE_ECOLE       := "res://_Game/Scenes/Lieu_Ecole.tscn"
const SCENE_BATEAU      := "res://_Game/Scenes/Lieu_Bateau.tscn"
const SCENE_LECTEUR     := "res://_Game/Scenes/LecteurHistoire.tscn"

# --- Fichiers ---
const FICHIER_SAUVEGARDE := "user://sauvegarde.json"
const FICHIER_PREFERENCES := "user://preferences.cfg"

# --- Groupes (remplacent les Tags Unity) ---
const GROUP_JOUEUR      := "joueur"
const GROUP_INTERACTIF  := "interactif"
const GROUP_CHARGEMENT  := "ecran_chargement"

# --- Préférences ---
const PREF_PREMIER_LANCEMENT := "premier_lancement"

# --- Avatar ---
const VITESSE_AVATAR    := 150.0
const VITESSE_MAX       := 250.0

# --- UI ---
const DUREE_FONDU           := 0.4
const DUREE_CHARGEMENT_MIN  := 0.5
