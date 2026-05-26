class_name HistoireBibliqueSO extends Resource

@export var histoire_id:         String             = ""
@export var titre:               String             = ""
@export_multiline var resume:    String             = ""
@export var panneaux:            Array[PanneauHistoire] = []
@export var narration_globale:   AudioStream
