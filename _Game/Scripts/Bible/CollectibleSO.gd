class_name CollectibleSO extends ObjetSO
# Carte biblique à collectionner — étend ObjetSO avec contexte narratif.

@export_multiline var texte_contexte: String = ""
@export var histoire_liee:  HistoireBibliqueSO
@export var verset_lie_res: VersetSO
