#extends Node
class_name CharacterStats
extends Resource

@export var health: int
@export var strength: int

func _init(p_health = 20, p_strength = 5) -> void:
	health = p_health
	strength = p_strength


func set_health(new_health: int, character):
	health = new_health
	if health <= 0:
		character.remove()
