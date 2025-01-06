extends Resource

class_name Armor
@export var Name: String
@export var defence: int
@export var weight: int
@export var type: String

func applybuff(player) -> void:
	pass

class top: extends Armor

class bottom: extends Armor

class shoes: extends Armor

class headwear: extends Armor

class gloves: extends Armor
