# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/global/global_music_manager.gd

extends Node

## public vars
var music_player: AudioStreamPlayer

## Built-In _ready() is called on startup
func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

## public methods
func play_music(path: String, use_fallback: bool = false) -> void:
	var final_path := path
	var fallback_path := path.replace(Globals.OST_COPYRIGHT_DIR, Globals.OST_FALLBACK_DIR)

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
	_apply_volume()


func stop_music(fade_time: float = 1.0) -> void:
	if not music_player.playing:
		return

	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -40, fade_time)

	await tween.finished
	music_player.stop()

func set_volume(music_volume: float) -> void:
	Globals.volume_music = music_volume
	_apply_volume()

func distinct_music_loader(path: String, volume: float, fade_time: float) -> void:
	await stop_music(fade_time)

	Globals.volume_music = volume
	play_music(path)

func music_loader(path: String, volume: float) -> void:
	Globals.volume_music = volume
	play_music(path)

## private methods
func _apply_volume() -> void:
	var effective := Globals.volume_general * Globals.volume_music

	if effective <= 0.0:
		music_player.volume_db = -80
	else:
		music_player.volume_db = linear_to_db(effective)
