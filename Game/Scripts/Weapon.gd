extends Resource
extends Node2D

class_name Weapon
@export var Name: String
@export var damage: int
@export var attacktype: String
@export var range: float
@export var attackspeed: float
var weapon_owner: Node2D

#when node enters scene tree
func _ready():
	print("Weapon")
	
#every frame
#func _proceess():

func equip(user: Node2D):
	weapon_owner = user
	print("Weapon equipped by ", user.name)

func unequip(user: Node2D):
	if weapon_owner == user:
		weapon_owner = null
		print("Weapon was unequipped by ", user.name)
class Bow: extends Weapon

class Sword: extends Weapon

class Axe: extends Weapon

class Daggers: extends Weapon

class Hammer: extends Weapon
