## A base for gameplay.
extends Node2D
class_name Gameplay

@export var background_music : Sound

func _enter_tree():
	SoundPlayer.play_music("BGM", background_music)

func setup(options := {}):
	pass
