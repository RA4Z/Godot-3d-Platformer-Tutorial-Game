extends HBoxContainer

@onready var coin_label: Label = $coin_label
@onready var life_label = $life_label

func _ready():
	life_label.text = str(3)
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)

func update_life(health: int):
	life_label.text = "%d" %health

func update_coin(amount: int):
	coin_label.text = "%d" % amount
