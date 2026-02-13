# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/global/global_music_manager.gd

extends Node

## public vars
var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

const MUSIC_BUS := "Music"
const SFX_BUS := "SFX"


## Built-In _ready() is called on startup
func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = MUSIC_BUS
	add_child(music_player)

	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = SFX_BUS
	add_child(sfx_player)

	_apply_music_volume()
	_apply_sfx_volume()

## =========================
## PUBLIC METHODS
## =========================

func play_music(path: String, use_fallback: bool = false) -> void:
	var final_path := path
	var fallback_path := path.replace(
		Globals.OST_COPYRIGHT_DIR,
		Globals.OST_FALLBACK_DIR
	)

	if use_fallback:
		final_path = fallback_path
	else:
		if not ResourceLoader.exists(final_path):
			if ResourceLoader.exists(fallback_path):
				final_path = fallback_path
			else:
				push_warning("Music not found (original + fallback): " + path)
				music_player.stop()
				return

	if not ResourceLoader.exists(final_path):
		push_warning("Music file missing: " + final_path)
		music_player.stop()
		return

	var new_stream = load(final_path)

	if new_stream == null or not new_stream is AudioStream:
		push_warning("Invalid audio resource: " + final_path)
		music_player.stop()
		return

	if music_player.stream == new_stream:
		return

	music_player.stream = new_stream
	music_player.play()

func stop_music(fade_time: float = 1.0) -> void:
	if not music_player.playing:
		return

	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -40, fade_time)

	await tween.finished
	music_player.stop()
	
	_apply_music_volume()

func set_music_volume(value: float) -> void:
	Globals.volume_music = value
	_apply_music_volume()

func set_sfx_volume(value: float) -> void:
	Globals.volume_sfx = value
	_apply_sfx_volume()

func play_sfx(path: String) -> void:
	if not ResourceLoader.exists(path):
		push_warning("SFX not found: " + path)
		return

	var stream = load(path)
	if stream == null or not stream is AudioStream:
		push_warning("Invalid SFX resource: " + path)
		return

	sfx_player.stream = stream
	sfx_player.play()


## =========================
## PRIVATE METHODS
## ========================
func _apply_music_volume() -> void:
	var bus_index = AudioServer.get_bus_index(MUSIC_BUS)

	if Globals.volume_music <= 0.0:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(Globals.volume_music)
		)

func _apply_sfx_volume() -> void:
	var bus_index = AudioServer.get_bus_index(SFX_BUS)

	if Globals.volume_sfx <= 0.0:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(Globals.volume_sfx)
		)
