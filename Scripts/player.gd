extends StaticBody2D

@onready var message_box_scene = preload("res://Scenes/MessageBox.tscn")

# Extensions
var data_inventory: DataInventory = DataInventory.new(5)
var character_actions: CharacterActions = CharacterActions.new()
var character_stats: CharacterStats = CharacterStats.new(15, 5)

var local_handler: Node2D
var region_handler: Node2D

func _ready() -> void:
	print("init player")
	InputController.pickpocket_victim_triggered.connect(pickpocket_target)
	InputController.slab_victim_triggered.connect(slab_target)

func trigger_movement(end_position: Vector2):
	if $MoveOperator.trigger_movement(end_position, self):
		if Global.get_game_state() == Global.GameState.LOCAL:
			manage_layers()

func manage_layers():
	TilesInterface.update_layer_positions(TilesInterface.trueCoords_to_tileCoords(self.global_position))
		
	local_handler.generate_all_near_locals(TilesInterface.current_location_continent)
	local_handler.draw_all_near_locals()
	local_handler.unload_all_far_away_locals()
	
	region_handler.generate_all_near_regions()
	region_handler.draw_all_near_regions()
	region_handler.unload_all_far_away_regions()

func pickpocket_target():
	print("pickpocket!")
	var collision_ray: ShapeCast2D = $MoveOperator.get_node("ShapeCast2D")
	if collision_ray.is_colliding():
		var target = collision_ray.get_collider(0)
		var stolen_money = character_actions.pickpocket(self, target)
		GameEventController.show_message_box("You stole {amount} money!".format({"amount": stolen_money}), 3, 2)
		data_inventory.money += stolen_money
	else:
		print("No victim in sight")

func slab_target():
	var collision_ray = $MoveOperator.get_node("ShapeCast2D")
	if collision_ray.is_colliding():
		var target = collision_ray.get_collider(0)
		var delivered_damage = character_actions.slab(self, target)
		GameEventController.show_message_box("You delivered {amount} damage!".format({"amount": delivered_damage}), 3, 2)
	else:
		print("No victim in sight")
