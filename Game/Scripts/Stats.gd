extends Resource
class_name Stats

@export var attack : int = 100
@export var health : int = 200
@export var speed : int = 100
@export var gravity : int = 200
@export var jump_height : int = -100

func take_damage(amount : int) -> void:
	health -= amount
