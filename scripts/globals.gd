# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/globals.gd

extends Node

#consts
const BASE_NAME: String = "RTS Game"
const VERSION: String = "0.3.2.alpha.windows"
const GAME_NAME: String = BASE_NAME + " " + "("+ VERSION +")"
const RESOLUTIONS: Dictionary = {
	0: "1280x720",
	1: "1366x768",
	2: "1600x900",
	3: "1920x1080",
	4: "2560x1440",
	5: "3840x2160"
}
const WINDOW_MODES: Dictionary = {
	0: "Windowed",
	1: "Borderless",
	2: "Fullscreen"
}

# public vars
var volume_sfx: float = 1.0
var volume_music: float = 1.0
var volume_general: float = 1.0

var current_window_mode: String = WINDOW_MODES[0]
var current_resolution: String = RESOLUTIONS[0]
