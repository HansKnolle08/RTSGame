# Copyright (c) 2026 Hansisi
# MIT License
# res://rts_components/rts_selection_manager/rts_selection_manager.gd

extends Node

## enums
## consts
const DRAGBOX_MIN_SIZE: int = 4

## exports
## public vars
## private vars
## onready vars
@onready var ui_dragbox: NinePatchRect = $SelectionRect

## built-in override methods

## Built-In _ready() is called on startup
func _ready() -> void:
	pass

## Built-In _process() is called on every frame
func _process(delta: float) -> void:
	pass

## public methods
func update_selection_rectangle(new_rect: Rect2) -> void:
	new_rect = new_rect.abs()
	ui_dragbox.position = new_rect.position
	ui_dragbox.size = new_rect.size
	
	if new_rect.get_area() > DRAGBOX_MIN_SIZE:
		ui_dragbox.show()

func dragbox_show() -> void:
	ui_dragbox.show()

func dragbox_hide() -> void:
	ui_dragbox.hide()

## private methods
func _select_object(object: Node) -> void:
	object.selected = true

func _deselect_object(object: Node) -> void:
	object.selected = false

func _toggle_select_object(object: Node) -> void:
	object.selected = !object.selected
# Part 6 pausiert bei: 15:42
