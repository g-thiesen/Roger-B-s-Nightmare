#extends Node
class_name CharacterActions

var rng := RandomNumberGenerator.new()

func pickpocket(doer, victim) -> int:
	if not doer.data_inventory:
		print("The doer has no inventory!")
		return 0
	if not victim.data_inventory:
		print("The victim has no inventory!")
		return 0
	if not doer.global_position.distance_to(victim.global_position) < 2*TilesInterface.TILE_SIZE:
		print("Victim is to far away!")
		return 0

	var max_stealable_money = roundi(0.75 * victim.data_inventory.money)
	var amount_stolen_money = rng.randi_range(0, max_stealable_money)
	victim.data_inventory.money -= amount_stolen_money
	return amount_stolen_money

func slab(doer, victim) -> int:
	if not doer.character_actions:
		print("The doer has no actions!")
		return 0
	if not doer.character_stats:
		print("The doer has no stats!")
		return 0
	if not victim.character_stats:
		print("The victim has no stats!")
		return 0
	if not doer.global_position.distance_to(victim.global_position) < 2*TilesInterface.TILE_SIZE:
		print("Victim is to far away!")
		return 0

	var delivered_damage = rng.randi_range(0, doer.character_stats.strength)
	var new_health = victim.character_stats.health - delivered_damage
	victim.character_stats.set_health(new_health, victim)
	return delivered_damage
