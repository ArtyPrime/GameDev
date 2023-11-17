extends Node

func _ready():
		Utility.saveGame()
		#Utility.loadGame()

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	Game.playerHP = 3
	get_tree().change_scene_to_file("res://world.tscn")
