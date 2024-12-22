class_name UpgradeManager extends Node

var faster:Upgrade=preload("res://src/upgrades/resources/speed1.tres") as Upgrade
var even_faster:Upgrade=preload("res://src/upgrades/resources/speed2.tres") as Upgrade
var stamina_meter:Upgrade=preload("res://src/upgrades/resources/meter_stamina.tres") as Upgrade
var turbo:Upgrade=preload("res://src/upgrades/resources/turbo.tres") as Upgrade
var jump:Upgrade=preload("res://src/upgrades/resources/jump.tres") as Upgrade

@export var all_upgrades:Array[Upgrade]=[
	preload("res://src/upgrades/resources/accel1.tres") as Upgrade,
	preload("res://src/upgrades/resources/accel2.tres") as Upgrade,
	preload("res://src/upgrades/resources/break1.tres") as Upgrade,
	preload("res://src/upgrades/resources/break2.tres") as Upgrade,
	preload("res://src/upgrades/resources/meter_avalanche.tres") as Upgrade,
	preload("res://src/upgrades/resources/meter_speed.tres") as Upgrade,
	stamina_meter,
	faster,
	even_faster,
	preload("res://src/upgrades/resources/speed3.tres") as Upgrade,
	preload("res://src/upgrades/resources/stamina1.tres") as Upgrade,
	preload("res://src/upgrades/resources/stamina2.tres") as Upgrade,
	preload("res://src/upgrades/resources/stamina3.tres") as Upgrade,
	preload("res://src/upgrades/resources/turn_speed1.tres") as Upgrade,
	preload("res://src/upgrades/resources/turn_speed2.tres") as Upgrade,
	preload("res://src/upgrades/resources/turn_speed3.tres") as Upgrade,
	jump,
	preload("res://src/upgrades/resources/turbo2.tres") as Upgrade,
	turbo
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
			Logger.debug("Possible %s" % u.name)
			possible.append(u)
	if faster in possible and even_faster in possible:
		Logger.warn("ERROR. Fast and Faster")
	return possible
	

func get_random_available(count:int=3)->Array[Upgrade]:
	var possible = get_available()
	var ret:Array[Upgrade]=[]
	if faster in possible:
		ret.append(faster)
		possible.erase(faster)
	elif turbo in possible:
		ret.append(turbo)
		possible.erase(turbo)
	elif stamina_meter in possible:
		ret.append(stamina_meter)
		possible.erase(stamina_meter)
	elif jump in possible:
		ret.append(jump)
		possible.erase(jump)
		
	for i in range(count-ret.size()):
		if possible.is_empty():
			break
		var u = possible.pick_random()
		ret.append(u)
		possible.erase(u)
	return ret
	

func maximum_speed() -> float:
	var max_turbo: float
	var max_speed: float
	for upgrade in available:
		if upgrade.property_name == "turbo_factor" and upgrade.value > max_turbo:
			max_turbo = upgrade.value
		if upgrade.property_name == "speed" and upgrade.value > max_speed:
			max_speed = upgrade.value
	return max_turbo * max_speed
	

func apply(upgrade:Upgrade)-> void:
	if not upgrade is UpgradeFloat or Globals.player.get(upgrade.property_name)< upgrade.value:
		Globals.player.set(upgrade.property_name, upgrade.value)
	Logger.info("applied %s. New value = %s" % [upgrade.name, Globals.player.get(upgrade.property_name)])
	applied.append(upgrade)
	available.erase(upgrade)
	
