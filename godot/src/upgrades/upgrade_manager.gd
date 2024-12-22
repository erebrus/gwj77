class_name UpgradeManager extends Node
@export var all_upgrades:Array[Upgrade]=[
	preload("res://src/upgrades/resources/accel1.tres") as Upgrade,
	preload("res://src/upgrades/resources/accel2.tres") as Upgrade,
	preload("res://src/upgrades/resources/break1.tres") as Upgrade,
	preload("res://src/upgrades/resources/break2.tres") as Upgrade,
	preload("res://src/upgrades/resources/meter_avalanche.tres") as Upgrade,
	preload("res://src/upgrades/resources/meter_distance.tres") as Upgrade,
	preload("res://src/upgrades/resources/meter_speed.tres") as Upgrade,
	preload("res://src/upgrades/resources/meter_stamina.tres") as Upgrade,
	preload("res://src/upgrades/resources/speed1.tres") as Upgrade,
	preload("res://src/upgrades/resources/speed2.tres") as Upgrade,
	preload("res://src/upgrades/resources/speed3.tres") as Upgrade,
	preload("res://src/upgrades/resources/stamina1.tres") as Upgrade,
	preload("res://src/upgrades/resources/stamina2.tres") as Upgrade,
	preload("res://src/upgrades/resources/stamina3.tres") as Upgrade,
	preload("res://src/upgrades/resources/turn_speed1.tres") as Upgrade,
	preload("res://src/upgrades/resources/turn_speed2.tres") as Upgrade,
	preload("res://src/upgrades/resources/turn_speed3.tres") as Upgrade,
	preload("res://src/upgrades/resources/jump.tres") as Upgrade,
	preload("res://src/upgrades/resources/turbo2.tres") as Upgrade,
	preload("res://src/upgrades/resources/turbo.tres") as Upgrade
]
var available:Array[Upgrade]=[]
var applied:Array[Upgrade]=[]


func init_list():
	available = []
	available.append_array(all_upgrades)	

func are_requirements_satisfied(upgrade:Upgrade)->bool:
	for r in upgrade.requirements:
		if not r in applied:
			return false
	return true

func get_available() -> Array[Upgrade]:
	var possible:Array[Upgrade]=[]
	for u in available:
		if are_requirements_satisfied(u):
			possible.append(u)
	return possible
	

func get_random_available(count:int=3)->Array[Upgrade]:
	var possible = get_available()
	var ret:Array[Upgrade]=[]
	for i in range(count):
		if possible.is_empty():
			break
		var u = possible.pick_random()
		ret.append(u)
		possible.erase(u)
	return ret

func apply(upgrade:Upgrade)-> void:
	Globals.player.set(upgrade.property_name, upgrade.value)
	applied.append(upgrade)
	available.erase(upgrade)
	Logger.info("applied %s. New value = %s" % [upgrade.name, Globals.player.get(upgrade.property_name)])
