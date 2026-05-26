extends Node
# Autoload "GestionnaireAudio" — AudioServer + deux bus (Musique / SFX).

@onready var _lecteur_musique: AudioStreamPlayer = $LecteurMusique
@onready var _lecteur_sfx:     AudioStreamPlayer = $LecteurSFX

const BUS_MUSIQUE := "Musique"
const BUS_SFX     := "SFX"

func _ready() -> void:
	_charger_preferences()

func jouer_musique(stream: AudioStream, boucle: bool = true) -> void:
	if _lecteur_musique.stream == stream and _lecteur_musique.playing:
		return
	_lecteur_musique.stream = stream
	_lecteur_musique.play()

func arreter_musique() -> void:
	_lecteur_musique.stop()

func jouer_sfx(stream: AudioStream) -> void:
	if stream == null:
		return
	_lecteur_sfx.stream = stream
	_lecteur_sfx.play()

func reglage_musique(volume_norme: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(BUS_MUSIQUE), _vers_db(volume_norme))
	_sauver_prefs()

func reglage_sfx(volume_norme: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(BUS_SFX), _vers_db(volume_norme))
	_sauver_prefs()

func _vers_db(t: float) -> float:
	return 20.0 * log(maxf(t, 0.0001)) / log(10.0)

func _charger_preferences() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(Constantes.FICHIER_PREFERENCES) != OK:
		return
	var vm: float = cfg.get_value("audio", "volume_musique", 0.8)
	var vs: float = cfg.get_value("audio", "volume_sfx",     1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(BUS_MUSIQUE), _vers_db(vm))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(BUS_SFX),     _vers_db(vs))

func _sauver_prefs() -> void:
	var cfg := ConfigFile.new()
	cfg.load(Constantes.FICHIER_PREFERENCES)
	var im := AudioServer.get_bus_index(BUS_MUSIQUE)
	var is_ := AudioServer.get_bus_index(BUS_SFX)
	cfg.set_value("audio", "volume_musique",
		pow(10.0, AudioServer.get_bus_volume_db(im) / 20.0))
	cfg.set_value("audio", "volume_sfx",
		pow(10.0, AudioServer.get_bus_volume_db(is_) / 20.0))
	cfg.save(Constantes.FICHIER_PREFERENCES)
